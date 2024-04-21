{{
  config(
    schema='STAGE'
  )
}}

{%- set yaml_metadata -%}
source_model: 'src_lineitem'
derived_columns:
  ORDER_KEY: 'L_ORDERKEY'
  PART_KEY: 'L_PARTKEY'
  SUPP_KEY: 'L_SUPPKEY'
  RECORD_SOURCE: '!TPCH-SOURCE'
hashed_columns:
  ORDER_PK:
    - 'ORDER_KEY'
  LINEITEM_PK:
    - 'ORDER_KEY'
    - 'L_LINENUMBER'
  PARTSUPP_PK:
    - 'PART_KEY'
    - 'SUPP_KEY'
  LINEITEM_HASHDIFF:
    is_hashdiff: true
    columns:
      - 'ORDER_KEY'
      - 'L_LINENUMBER'
      - 'L_COMMITDATE'
      - 'L_DISCOUNT'
      - 'L_EXTENDEDPRICE'
      - 'L_LINESTATUS'
      - 'L_COMMENT'
      - 'L_QUANTITY'
      - 'L_RECEIPTDATE'
      - 'L_RETURNFLAG'
      - 'L_SHIPDATE'
      - 'L_SHIPINSTRUCT'
      - 'L_SHIPMODE'
      - 'L_TAX'
	

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
