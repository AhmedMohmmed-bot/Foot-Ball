-- ترتيب الفرق في كل دوري بناءً على النقاط والأهداف المسجلة
select
    l.leaguename,
    t.teamname ,
    SUM(r.points) AS TotalPoints,
    SUM(r.goalsscored) AS TotalGoals
from matchresult r
join subscribe s on r.matchid = s.matchid and s.teamid = r.teamid
join team t on s.teamid = t.teamid
join league l on t.leagueid = l.leagueid
group by l.leaguename, t.teamname
order by TotalPoints , TotalGoals desc;

