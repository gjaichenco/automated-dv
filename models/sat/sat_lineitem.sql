{{
  config(
    schema='SAT',
    materialized='incremental'
  )
}}



{%- set source_model = "stg_lineitem" -%}
{%- set src_pk = "LINEITEM_PK" -%}
{%- set src_hashdiff = "LINEITEM_HASHDIFF" -%}
{%- set src_payload = [
        'L_LINENUMBER'
      , 'L_COMMITDATE'
      , 'L_DISCOUNT'
      , 'L_EXTENDEDPRICE'
      , 'L_LINESTATUS'
      , 'L_COMMENT'
      , 'L_QUANTITY'
      , 'L_RECEIPTDATE'
      , 'L_RETURNFLAG'
      , 'L_SHIPDATE'
      , 'L_SHIPINSTRUCT'
      , 'L_SHIPMODE'
      , 'L_TAX'
 ] -%}

{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.sat(src_pk=src_pk, src_hashdiff=src_hashdiff,
                   src_payload=src_payload, src_eff=none,
                   src_ldts=src_ldts, src_source=src_source,
                   source_model=source_model) }}