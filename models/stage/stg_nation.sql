{{
  config(
    schema='STAGE'
  )
}}

{%- set yaml_metadata -%}
source_model: 'src_nation'
derived_columns:
  NATION_KEY: 'N_NATIONKEY'
  REGION_KEY: 'N_REGIONKEY'
  RECORD_SOURCE: '!TPCH-SOURCE'
hashed_columns:
  NATION_PK: 
      - 'NATION_KEY'
  REGION_PK: 
      - 'REGION_KEY'
  NATION_REGION_PK: 
      - 'NATION_KEY'
      - 'REGION_KEY'
  NATION_HASHDIFF:
    is_hashdiff: true
    columns:
      - 'NATION_KEY'
      - 'N_NAME'
      - 'REGION_KEY'
      - 'N_COMMENT'
	

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
