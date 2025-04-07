create or replace function Q9(partial_name TEXT)
RETURNS TABLE(maker TEXT, cheese TEXT, style TEXT) AS $$
BEGIN
RETURN QUERY
SELECT 

m.name AS maker
FROM makers m
JOIN cheeses c ON c.made_by = m.id
JOIN styles s ON c.styles = s.id
WHERE m.name ILIKE '%' || partial_name || '%'
ORDER BY m.name
END;
$$ LANGUAGE plpgsql;
