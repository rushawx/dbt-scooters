select distinct
    user_id,
    "timestamp",
    type_id
from
    {{ source("scooters_raw", "events") }}
{% if is_incremental() %}
where
    "timestamp" > (select max("timestamp") from {{ this }})
    and "timestamp" <= (select date(max("timestamp")) + interval '2' month from {{ this }})
{% else %}
where
    "timestamp" < date '2023-08-01'
{% endif %}
