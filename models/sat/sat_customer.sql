{{
  config(
    schema='SAT',
    materialized='incremental'
  )
}}



{%- set source_model = "stg_customer" -%}
{%- set src_pk = "CUSTOMER_PK" -%}
{%- set src_hashdiff = "CUSTOMER_HASHDIFF" -%}
{%- set src_payload = ['C_NAME'
      , 'C_ADDRESS'
      , 'C_PHONE'
      , 'C_ACCTBAL'
      , 'C_MKTSEGMENT'
      , 'C_COMMENT'] -%}

{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.sat(src_pk=src_pk, src_hashdiff=src_hashdiff,
                   src_payload=src_payload, src_eff=none,
                   src_ldts=src_ldts, src_source=src_source,
                   source_model=source_model) }}