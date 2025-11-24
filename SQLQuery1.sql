-- ترتيب الفرق في كل دوري بناءً على النقاط والأهداف المسجلة
    T.TeamName,
    SUM(R.Points) AS TotalPoints,
    SUM(R.GoalsScored) AS TotalGoals
FROM MatchResult R
JOIN Subscribe S ON R.MatchID = S.MatchID AND R.TeamID = S.TeamID
JOIN Team T ON R.TeamID = T.TeamID
JOIN League L ON T.LeagueID = L.LeagueID
GROUP BY L.LeagueName, T.TeamName
ORDER BY L.LeagueName, TotalPoints DESC, TotalGoals DESC;

