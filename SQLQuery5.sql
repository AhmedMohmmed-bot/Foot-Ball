-- اللاعبين الذين سجلوا أكثر من 3 أهداف في دوري معين
select
    l.leaguename,
    p.firstname + ' ' + p.lastname as playername,
    t.teamname,
    count(g.goalid) as totalgoals
from goal g
join player p on g.playerid = p.playerid
join team t on p.teamid = t.teamid
join league l on t.leagueid = l.leagueid
where l.leaguename = 'la liga'    -- ضع اسم الدوري هنا
group by l.leaguename, p.firstname, p.lastname, t.teamname
having count(g.goalid) > 3
order by totalgoals desc;