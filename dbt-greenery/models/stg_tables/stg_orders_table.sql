{{
  config(
    materialized='table'
  )
}}

SELECT * FROM {{ source('greenery_orders', 'orders') }}