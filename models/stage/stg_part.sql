{{
  config(
    schema='STAGE'
  )
}}

{%- set yaml_metadata -%}
source_model: 'src_part'
derived_columns:
  PART_KEY: 'P_PARTKEY'
  RECORD_SOURCE: '!TPCH-SOURCE'
hashed_columns:
  PART_PK: 'PART_KEY'
  PART_HASHDIFF:
    is_hashdiff: true
    columns:
      - 'PART_KEY'
      - 'P_BRAND'
      - 'P_COMMENT'
      - 'P_CONTAINER'
      - 'P_MFGR'
      - 'P_NAME'
      - 'P_RETAILPRICE'
      - 'P_SIZE'
      - 'P_TYPE'
	

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
