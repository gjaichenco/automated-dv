{{
  config(
    schema='STAGE'
  )
}}

{%- set yaml_metadata -%}
source_model: 'src_orders'
derived_columns:
  ORDER_KEY: 'O_ORDERKEY'
  CUSTOMER_KEY: 'O_CUSTKEY'
  RECORD_SOURCE: '!TPCH-SOURCE'
hashed_columns:
  ORDER_PK: 'ORDER_KEY'
  CUSTOMER_PK: 'CUSTOMER_KEY'
  ORDER_CUSTOMER_PK:
    - 'CUSTOMER_KEY'
    - 'ORDER_KEY'
  ORDER_HASHDIFF:
    is_hashdiff: true
    columns:
      - 'ORDER_KEY'
      - 'O_CLERK'
      - 'O_ORDERDATE'
      - 'O_ORDERPRIORITY'
      - 'O_ORDERSTATUS'
      - 'O_COMMENT'
      - 'O_SHIPPRIORITY'
      - 'O_TOTALPRICE'
	

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
