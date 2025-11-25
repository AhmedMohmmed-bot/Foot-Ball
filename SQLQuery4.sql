-- متوسط حضور المباريات الذي يتجاوز المتوسط لكل دوري
select
    m.matchid,
    l.leaguename,
    m.stadium,
    m.attendance,
    m.matchdate
from match m
join league l on m.leagueid = l.leagueid
where m.attendance >
(
    select avg (M2.Attendance)
    from match M2
    where M2.leagueid = m.leagueid
)
order by m.attendance desc;