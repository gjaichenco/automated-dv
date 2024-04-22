{{
  config(
    schema='LNK',
    materialized='incremental'
  )
}}


{%- set source_model = "stg_lineitem" -%}
{%- set src_pk = "LINEITEM_PK" -%}
{%- set src_fk = ["ORDER_PK", "LINEITEM_PK", "PARTSUPP_PK"] -%}
{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                    src_source=src_source, source_model=source_model) }}
