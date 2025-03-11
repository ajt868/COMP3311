Need to make Styles.id = Cheeses.Style

create or replace view Q2(cheese,maker)
as
SELECT c.name, m.name
FROM cheeses c
JOIN styles s ON c.style = s.id
JOIN makers m on c.made_by = m.id
WHERE c.name = s.name
ORDER BY c.name;
;

