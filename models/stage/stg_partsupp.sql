{{
  config(
    schema='STAGE'
  )
}}

{%- set yaml_metadata -%}
source_model: 'src_partsupp'
derived_columns:
  PART_KEY: 'PS_PARTKEY'
  SUPP_KEY: 'PS_SUPPKEY'
  RECORD_SOURCE: '!TPCH-SOURCE'
hashed_columns:
  PARTSUPP_PK:
    - 'PART_KEY'
    - 'SUPP_KEY'
  PART_PK: 'PART_KEY' 
  SUPP_PK: 'SUPP_KEY'
  PARTSUPP_HASHDIFF:
    is_hashdiff: true
    columns:
      - 'PART_KEY'
      - 'SUPP_KEY'
      - 'PS_AVAILQTY'
      - 'PS_SUPPLYCOST'
      - 'PS_COMMENT'
	

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
