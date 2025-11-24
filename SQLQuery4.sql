-- متوسط حضور المباريات الذي يتجاوز المتوسط لكل دوري
SELECT 
    M.MatchID,
    L.LeagueName,
    M.Stadium,
    M.Attendance,
    M.MatchDate
FROM Match M
JOIN League L ON M.LeagueID = L.LeagueID
WHERE M.Attendance >
(
    SELECT AVG(M2.Attendance)
    FROM Match M2
    WHERE M2.LeagueID = M.LeagueID
)
ORDER BY M.Attendance DESC;