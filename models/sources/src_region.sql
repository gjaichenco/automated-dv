{{
  config(
    schema='SOURCE'
  )
}}


SELECT
  *
FROM {{ source('tpch_sample', 'REGION') }}