with
tmp_1 as (
	select
		l.started_at::date as date,
		l.user_id,
		(extract(day from l.started_at - r.birth_date) / 365)::int as age
	from scooters_raw.trips as l
		left join scooters_raw.users as r
			on l.user_id = r.id
),
tmp_2 as (
	select
		age,
		date,
		count(user_id) as trips
	from tmp_1
	group by age, date
)
select
	age,
	avg(trips)
from tmp_2
group by age
order by age asc
