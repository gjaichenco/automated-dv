{{
  config(
    schema='SAT',
    materialized='incremental'
  )
}}



{%- set source_model = "stg_part" -%}
{%- set src_pk = "PART_PK" -%}
{%- set src_hashdiff = "PART_HASHDIFF" -%}
{%- set src_payload = [   
        'P_BRAND'
      , 'P_COMMENT'
      , 'P_CONTAINER'
      , 'P_MFGR'
      , 'P_NAME'
      , 'P_RETAILPRICE'
      , 'P_SIZE'
      , 'P_TYPE'
       ] -%}

{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.sat(src_pk=src_pk, src_hashdiff=src_hashdiff,
                   src_payload=src_payload, src_eff=none,
                   src_ldts=src_ldts, src_source=src_source,
                   source_model=source_model) }}