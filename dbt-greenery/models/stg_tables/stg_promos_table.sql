{{
  config(
    materialized='table'
  )
}}

SELECT
        id,
        promo_id,
        discout as discount,
        status

FROM {{ source('greenery_promos', 'promos') }}