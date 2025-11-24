-- متوسط نسبة الاستحواذ لكل فريق في كل دوري
SELECT 
    T.TeamName,
    L.LeagueName,
    AVG(S.Possession) AS AvgPossession
FROM TeamMatchStats S
JOIN Team T ON S.TeamID = T.TeamID
JOIN League L ON T.LeagueID = L.LeagueID
GROUP BY T.TeamName, L.LeagueName
ORDER BY AvgPossession DESC;