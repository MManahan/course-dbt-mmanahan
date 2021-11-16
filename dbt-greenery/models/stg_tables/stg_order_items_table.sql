{{
  config(
    materialized='table'
  )
}}

SELECT * FROM {{ source('greenery_order_items', 'order_items') }}