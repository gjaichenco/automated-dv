{{
  config(
    schema='HUB',
    materialized='incremental'
  )
}}

{%- set source_model = "stg_region" -%}
{%- set src_pk = "REGION_PK" -%}
{%- set src_nk = "REGION_KEY" -%}
{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
    src_source=src_source, source_model=source_model) }}