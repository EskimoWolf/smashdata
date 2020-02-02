select
		c.`id`,
		c.`name`,
		c.`series`,
--		c.`image`,
--		c.`icon`,
		c.`color`,
        c.`image_url`
from
    characters c
    join (
        select
            c.`series`,
            count(*) 'count'
        from
            characters c
        where
            c.`active` = 1
        group by
            c.`series`
    ) t on t.`series` = c.`series`
where
    c.`active` = 1
order by
    t.count desc,
    c.`series` asc,
    c.`id` asc;