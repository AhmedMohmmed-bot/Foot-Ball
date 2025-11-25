--هداف الدوري الأعلى تسجيلًا في دوري "لا ليغا"
select top 1
    l.leaguename,
    p.firstname +''+ p.lastname as PlayerName,
    t.teamname,
    count (g.goalid) as Goals
from goal g 
join player p on g.playerid = p.playerid
join team t on p.teamid = t.teamid
join league l on t.leagueid = l.leagueid
where leaguename = 'La Liga'   -- اسم الدوري المطلوب
group by l.leaguename, p.firstname, p.lastname, t.teamname
order by Goals desc;