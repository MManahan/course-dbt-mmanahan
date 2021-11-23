{% snapshot snap_users %}

{{
    config(
      target_database='dbt',
      target_schema='snapshots',
      unique_key='user_id',

      strategy='timestamp',
      updated_at='updated_at_users',
    )
}}

select * from {{ref('stg_users_table')}}

{% endsnapshot %}