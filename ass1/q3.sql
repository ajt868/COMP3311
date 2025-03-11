Write an SQL view Q3(cheese,maker) that returns a list of cheeses which are described as "crumbly" (in their style notes)

create or replace view Q3(cheese,maker)
as
SELECT c.name, m.name
FROM cheeses c
JOIN styles s ON c.style = s.id
JOIN makers m on c.made_by = m.id
WHERE s.notes ILIKE '%crumbly%'
ORDER BY c.name;-- your code here
;
