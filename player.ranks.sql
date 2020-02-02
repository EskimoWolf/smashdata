select
	p.name 'player',
    c.name 'character',
	wins,
    losses,
    round((wins / (wins + losses)) * 100,2)  'percent',
    pr.`rank`,
    c.color,
    case
		when pr.`rank` >= 1400 then 'XXX'
		when pr.`rank` >= 1350 then 'SSS'
		when pr.`rank` >= 1300 then 'SS'
        when pr.`rank` >= 1200 then 'S'
        when pr.`rank` >= 1100 then 'A'
        when pr.`rank` >= 1000 then 'B'
        when pr.`rank` >= 900 then 'C'
        when pr.`rank` >= 800 then 'D'
	else 'F' end 'rank_letter',
    c.image_url 'image'
from
	players_rankings pr
    join characters c on pr.character = c.id
    join players p on pr.player = p.id
where
	p.id not in (6,8)
order by
	p.name,
	(wins / (wins + losses)) * 100 desc,
    c.name