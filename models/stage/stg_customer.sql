{{
  config(
    schema='STAGE'
  )
}}

{%- set yaml_metadata -%}
source_model: 'src_customer'
derived_columns:
  CUSTOMER_KEY: 'C_CUSTKEY'
  RECORD_SOURCE: '!TPCH-SOURCE'
hashed_columns:
  CUSTOMER_PK: 'CUSTOMER_KEY'
  CUSTOMER_HASHDIFF:
    is_hashdiff: true
    columns:
      - 'CUSTOMER_KEY'
      - 'C_NAME'
      - 'C_ADDRESS'
      - 'C_PHONE'
      - 'C_ACCTBAL'
      - 'C_MKTSEGMENT'
      - 'C_COMMENT'
	

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
