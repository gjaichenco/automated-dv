{{
  config(
    schema='STAGE'
  )
}}

{%- set yaml_metadata -%}
source_model: 'src_supplier'
derived_columns:
  SUPP_KEY: 'S_SUPPKEY'
  NATION_KEY: 'S_NATIONKEY'
  RECORD_SOURCE: '!TPCH-SOURCE'
hashed_columns:
  SUPP_PK: 'SUPP_KEY'
  NATION_PK: 'NATION_KEY'
  SUPP_NATION_PK:
      - 'SUPP_KEY'
      - 'NATION_KEY'
  SUPP_HASHDIFF:
    is_hashdiff: true
    columns:
      - 'SUPP_KEY'
      - 'S_ACCTBAL'
      - 'S_ADDRESS'
      - 'S_PHONE'
      - 'S_COMMENT'
      - 'S_NAME'
	

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
