WITH StyleCounts AS (
    SELECT p.country, COUNT(DISTINCT s.id) AS distinct_styles
    FROM places p
    JOIN makers m ON m.located_in = p.id
    JOIN cheeses c ON c.made_by = m.id
    JOIN styles s ON c.style = s.id
    GROUP BY p.country
)
SELECT country
FROM StyleCounts
WHERE distinct_styles = (SELECT MAX(distinct_styles) FROM StyleCounts);
