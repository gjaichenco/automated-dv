{%- macro postgres__sat(src_pk, src_hashdiff, src_payload, src_extra_columns, src_eff, src_ldts, src_source, source_model) -%}

{%- set source_cols = dbtvault.expand_column_list(columns=[src_pk, src_hashdiff, src_payload, src_extra_columns, src_eff, src_ldts, src_source]) -%}
{%- set rank_cols = dbtvault.expand_column_list(columns=[src_pk, src_hashdiff, src_ldts]) -%}
{%- set pk_cols = dbtvault.expand_column_list(columns=[src_pk]) -%}
{%- set enable_ghost_record = var('enable_ghost_records', false) -%}

{%- if model.config.materialized == 'vault_insert_by_rank' %}
    {%- set source_cols_with_rank = source_cols + dbtvault.escape_column_names([config.get('rank_column')]) -%}
{%- endif -%}

{{ dbtvault.prepend_generated_by() }}

WITH source_data AS (
    {%- if model.config.materialized == 'vault_insert_by_rank' %}
    SELECT {{ dbtvault.prefix(source_cols_with_rank, 'a', alias_target='source') }}
    {%- else %}
    SELECT {{ dbtvault.prefix(source_cols, 'a', alias_target='source') }}
    {%- endif %}
    FROM {{ ref(source_model) }} AS a
    WHERE {{ dbtvault.multikey(src_pk, prefix='a', condition='IS NOT NULL') }}
    {%- if model.config.materialized == 'vault_insert_by_period' %}
    AND __PERIOD_FILTER__
    {% elif model.config.materialized == 'vault_insert_by_rank' %}
    AND __RANK_FILTER__
    {% endif %}
),

{%- if dbtvault.is_any_incremental() %}

latest_records AS (
    SELECT {{ dbtvault.prefix(rank_cols, 'a', alias_target='target') }}
    FROM (
        SELECT {{ dbtvault.prefix(rank_cols, 'current_records', alias_target='target') }},
            RANK() OVER (
                PARTITION BY {{ dbtvault.prefix([src_pk], 'current_records') }}
                ORDER BY {{ dbtvault.prefix([src_ldts], 'current_records') }} DESC
            ) AS rank
        FROM {{ this }} AS current_records
            JOIN (
                SELECT DISTINCT {{ dbtvault.prefix([src_pk], 'source_data') }}
                FROM source_data
            ) AS source_records
                ON {{ dbtvault.multikey(src_pk, prefix=['current_records','source_records'], condition='=') }}
    ) AS a
    WHERE a.rank = 1
),

{%- endif %}

{%- if enable_ghost_record %}

ghost AS (
{{- dbtvault.create_ghost_records(source_model, source_cols, hashes=[src_pk, src_hashdiff], record_source=src_source) }}
),

{%- endif %}

records_to_insert AS (
    {%- if enable_ghost_record -%}
    SELECT
        {{ dbtvault.alias_all(source_cols, 'g') }}
        FROM ghost AS g
        {%- if dbtvault.is_any_incremental() %}
        WHERE NOT EXISTS ( SELECT 1 FROM {{ this }} AS h WHERE {{ dbtvault.prefix([src_hashdiff], 'h', alias_target='target') }} = {{ dbtvault.prefix([src_hashdiff], 'g') }} )
        {%- endif %}
    UNION
    {%- endif %}
    SELECT DISTINCT {{ dbtvault.alias_all(source_cols, 'stage') }}
    FROM source_data AS stage
    {%- if dbtvault.is_any_incremental() %}
        LEFT JOIN latest_records
            ON {{ dbtvault.multikey(src_pk, prefix=['latest_records','stage'], condition='=') }}
            WHERE {{ dbtvault.prefix([src_hashdiff], 'latest_records', alias_target='target') }} != {{ dbtvault.prefix([src_hashdiff], 'stage') }}
                OR {{ dbtvault.prefix([src_hashdiff], 'latest_records', alias_target='target') }} IS NULL
    {%- endif %}
)

SELECT * FROM records_to_insert

{%- endmacro -%}