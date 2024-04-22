{{
  config(
    schema='SAT',
    materialized='incremental'
  )
}}



{%- set source_model = "stg_supplier" -%}
{%- set src_pk = "SUPP_PK" -%}
{%- set src_hashdiff = "SUPP_HASHDIFF" -%}
{%- set src_payload = [
        'S_ACCTBAL'
      , 'S_ADDRESS'
      , 'S_PHONE'
      , 'S_COMMENT'
      , 'S_NAME'
 ] -%}

{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.sat(src_pk=src_pk, src_hashdiff=src_hashdiff,
                   src_payload=src_payload, src_eff=none,
                   src_ldts=src_ldts, src_source=src_source,
                   source_model=source_model) }}