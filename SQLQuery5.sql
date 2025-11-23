--«·›—ﬁ «·√ﬁ·  ⁄—÷ ··√Œÿ«¡ 
SELECT 
    T.TeamName,
    L.LeagueName,
    SUM(S.Fouls) AS TotalFouls
FROM TeamMatchStats S
JOIN Team T ON S.TeamID = T.TeamID
JOIN League L ON T.LeagueID = L.LeagueID
GROUP BY T.TeamName, L.LeagueName
ORDER BY TotalFouls ASC;