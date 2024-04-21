{{
  config(
    schema='STAGE'
  )
}}

{%- set yaml_metadata -%}
source_model: 'src_region'
derived_columns:
  REGION_KEY: 'R_REGIONKEY'
  RECORD_SOURCE: '!TPCH-SOURCE'
hashed_columns:
  REGION_PK: 'REGION_KEY'
  REGION_HASHDIFF:
    is_hashdiff: true
    columns:
      - 'REGION_KEY'
      - 'R_NAME'
      - 'R_COMMENT'
	

{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{% set source_model = metadata_dict['source_model'] %}

{% set derived_columns = metadata_dict['derived_columns'] %}

{% set hashed_columns = metadata_dict['hashed_columns'] %}

WITH staging AS (
{{ automate_dv.stage(include_source_columns=true,
                     source_model=source_model,
                     derived_columns=derived_columns,
                     hashed_columns=hashed_columns,
                     ranked_columns=none) }}
)

SELECT *,
       current_timestamp() AS LOAD_DATE
FROM staging
