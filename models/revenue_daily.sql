select
    sum(price_rub) as revenue_rub,
    "date",
    now() at time zone 'utc' as updated_at
from {{ ref("trips_prep") }}
{% if is_incremental() %}
where "date" >= (select max("date") from {{ ref("trips_prep") }}) - interval '2' day
{% endif %}
group by "date", updated_at
order by "date" desc
