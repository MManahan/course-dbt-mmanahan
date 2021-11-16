{{
  config(
    materialized='table'
  )
}}

SELECT * FROM {{ source('greenery_users', 'users') }}