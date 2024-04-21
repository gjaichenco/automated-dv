{{
  config(
    schema='LNK'
  )
}}


{%- set source_model = "stg_partsupp" -%}
{%- set src_pk = "PARTSUPP_PK" -%}
{%- set src_fk = ["PART_PK", "SUPP_PK"] -%}
{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                    src_source=src_source, source_model=source_model) }}