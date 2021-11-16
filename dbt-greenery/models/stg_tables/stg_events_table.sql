{{
  config(
    materialized='table'
  )
}}

SELECT * FROM {{ source('greenery_events', 'events') }}