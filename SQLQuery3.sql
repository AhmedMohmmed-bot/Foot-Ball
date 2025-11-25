-- متوسط نسبة الاستحواذ لكل فريق في كل دوري
select
    t.teamname,
    l.leaguename,
    avg (s.possession) as AvgPossession
from teammatchstats s
join team t on s.teamid = t.teamid
join league l on t.leagueid = l.leagueid
group by t.teamname, l.leaguename
order by AvgPossession desc;