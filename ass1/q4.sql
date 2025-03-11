create or replace view q4(hardness, ncheeses) as
SELECT s.hardness, COUNT(c.id) AS ncheeses
FROM Styles s
JOIN Cheeses c ON c.style = s.id
GROUP BY s.hardness
ORDER BY
    CASE s.hardness
        WHEN 'soft' THEN 1
        WHEN 'semi-soft' THEN 2
        WHEN 'semi-hard' THEN 3
        WHEN 'hard' THEN 4
    END;
