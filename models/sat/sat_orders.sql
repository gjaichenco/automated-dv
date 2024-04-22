{{
  config(
    schema='SAT',
    materialized='incremental'
  )
}}



{%- set source_model = "stg_orders" -%}
{%- set src_pk = "ORDER_PK" -%}
{%- set src_hashdiff = "ORDER_HASHDIFF" -%}
{%- set src_payload = [
        'O_CLERK'
      , 'O_ORDERDATE'
      , 'O_ORDERPRIORITY'
      , 'O_ORDERSTATUS'
      , 'O_COMMENT'
      , 'O_SHIPPRIORITY'
      , 'O_TOTALPRICE'
 ] -%}

{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.sat(src_pk=src_pk, src_hashdiff=src_hashdiff,
                   src_payload=src_payload, src_eff=none,
                   src_ldts=src_ldts, src_source=src_source,
                   source_model=source_model) }}