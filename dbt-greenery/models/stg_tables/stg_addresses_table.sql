{{
  config(
    materialized='table'
  )
}}

SELECT * FROM {{ source('greenery_addresses', 'addresses') }}