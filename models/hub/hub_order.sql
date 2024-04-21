{{
  config(
    schema='HUB'
  )
}}


{%- set source_model = "stg_orders" -%}
{%- set src_pk = "ORDER_PK" -%}
{%- set src_nk = "ORDER_KEY" -%}
{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
    src_source=src_source, source_model=source_model) }}