--هداف الدوري الأعلى تسجيلًا في دوري "لا ليغا"
SELECT TOP 1
    L.LeagueName,
    P.FirstName + ' ' + P.LastName AS PlayerName,
    T.TeamName,
    COUNT(G.GoalID) AS Goals
FROM Goal G
JOIN Player P ON G.PlayerID = P.PlayerID
JOIN Team T ON P.TeamID = T.TeamID
JOIN League L ON T.LeagueID = L.LeagueID
WHERE L.LeagueName = 'La Liga'   -- اسم الدوري المطلوب
GROUP BY L.LeagueName, T.TeamName, P.FirstName, P.LastName
ORDER BY Goals DESC;