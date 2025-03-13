SELECT c.name AS cheese, m.name AS maker, c.aged_for AS aged, s.min_aging, s.max_aging 
FROM cheeses c
JOIN makers m ON c.made_by = m.id
JOIN styles s ON c.style = s.id
WHERE c.aged_for < s.min_aging OR c.aged_for > s.max_aging
ORDER BY c.name;
