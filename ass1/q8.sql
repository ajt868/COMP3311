create type recordtype as (maker test, location text);

create or replace function Q8(partial_name text) returns SETOF recordtype  AS $$
BEGIN
	RETURN QUERY
	SELECT
		m.name AS maker,
		(p.location || ', ' p.region) AS location
	FROM makers m
	JOIN places p ON m.located_in = p.id
	WHERE m.name ILIKE '%' || partial_name || '%'
	ORDER BY m.name;
END;
$$ LANGUAGE plpgsql;

create or replace function Q8(partial_name TEXT)
RETURNS TABLE (maker TEXT, location TEXT) AS $$
BEGIN
    RETURN QUERY
    SELECT
        m.name AS maker,
        TRIM(BOTH ', ' FROM (
            COALESCE(NULLIF(p.town, '') || ', ', '') ||
            COALESCE(NULLIF(p.region, '') || ', ', '') ||
            COALESCE(p.country, '')
       )) AS location
    FROM makers m
    JOIN places p ON m.located_in = p.id
    WHERE m.name ILIKE '%' || partial_name || '%'
    ORDER BY m.name;
END;
$$ LANGUAGE plpgsql;
