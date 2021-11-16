{{
  config(
    materialized='table'
  )
}}

SELECT * FROM {{ source('greenery_products', 'products') }}