{{
  config(
    materialized='table'
  )
}}

SELECT * FROM {{ source('greenery_promos', 'promos') }}