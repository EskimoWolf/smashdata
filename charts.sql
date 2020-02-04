with cte as (
select
	json_extract(m.meta_data,'$.player1.player') 'player'
--    ,json_extract(m.meta_data,'$.player1.character') 'character'
    ,json_extract(m.meta_data,'$.player1.win') 'win'
    ,m.date
    ,year(m.date) 'year'
    ,monthname(m.date) 'month'
    ,weekofyear(m.date) 'week'
from
	matches m

union all

select
	json_extract(m.meta_data,'$.player2.player') 'player'
--    ,json_extract(m.meta_data,'$.player2.character') 'character'
    ,json_extract(m.meta_data,'$.player2.win') 'win'
    ,m.date
    ,year(m.date) 'year'
    ,monthname(m.date) 'month'
    ,weekofyear(m.date) 'week'
from
	matches m
), date_range as (
select 
	p.id 'player'
    ,m.*
from
	players p,
	(
		select
			year(m.date) year
			,monthname(m.date) month
			,weekofyear(m.date) week
		from
			matches m
		group by
			year(m.date)
			,monthname(m.date)
			,weekofyear(m.date)
		order by
			m.date asc
    ) m
where
	p.id not in (8,6)
order by
	p.name asc
    ,m.year asc
    ,m.week asc
)

select
	p.name
    ,p.color
    ,r.`year`
    ,r.`month`
    ,r.`week`
    ,ifnull(c.wins,0) percent
from
	date_range r
	left join (
		select
			c.player
			,c.`year`
			,c.`month`
			,c.`week`
			,round((sum(c.win)/count(*))*100,0) wins
		from
			cte c
		where
			c.player not in (8,6)
		group by
			c.player
			,c.year
			,c.month
			,c.week
    ) c on c.player = r.player and c.year = r.year and c.month = r.month and c.week = r.week
    join players p on p.id = r.player
where
	p.id not in (8,6)
order by
	p.name asc
    ,r.year asc
    ,r.week asc