-- الفرق مع أقل عدد من الأخطاء في كل دوري
select 
    t.teamname,
    l.leaguename,
    sum(s.fouls) AS TotalFouls
FROM  teammatchstats s
JOIN team t on s.teamid = t.teamid
JOIN league l on t.leagueid = l.leagueid
group by t.teamname , l.leaguename
order by l.leaguename, TotalFouls asc;