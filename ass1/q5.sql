WITH CheeseCounts AS (
    SELECT s.name AS style, COUNT(c.id) AS cheese_count
    FROM Styles s
    JOIN Cheeses c ON c.style = s.id
    GROUP BY s.name
)
SELECT style
FROM CheeseCounts
WHERE cheese_count = (SELECT MAX(cheese_count) FROM CheeseCounts);
