{% snapshot snap_promos_check %}

    {{
        config(
          target_schema='snapshots',
          strategy='check',
          unique_key='promo_id',
          check_cols=['discount','status_promo'],
        )
    }}

    select * from {{ref('stg_promos_table')}}

{% endsnapshot %}