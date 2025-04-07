-- Q1: oldest cheesemaker



create or replace view Q1(maker,founded)
as
SELECT name,founded FROM makers
WHERE founded = (SELECT MIN(founded) FROM makers)
ORDER BY name;

-- Q2: cheese with same name as style

create or replace view Q2(cheese,maker)
as
SELECT c.name, m.name
FROM cheeses c
JOIN styles s ON c.style = s.id
JOIN makers m ON c.made_by = m.id
WHERE c.name = s.name
ORDER BY c.name;

-- Q3: Crumbly cheeses

create or replace view Q3(cheese,maker)
as
SELECT c.name, m.name
FROM cheeses c
JOIN styles s ON c.style = s.id
JOIN makers m ON c.made_by = m.id
WHERE s.notes ILIKE '%crumbly%'
ORDER BY c.name;

-- Q4: How many of each hardness level

create or replace view Q4(hardness,ncheeses)
as
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

-- Q5: Most popular cheese style
create or replace view Q5(style)
as
WITH CheeseCounts AS (
    SELECT s.name AS style, COUNT(c.id) AS cheese_count
    FROM Styles s
    JOIN Cheeses c ON c.style = s.id
    GROUP BY s.name
)
SELECT style
FROM CheeseCounts
WHERE cheese_count = (SELECT MAX(cheese_count) FROM CheeseCounts);

-- Q6: Country that makes the most styles of cheese

create or replace view Q6(country)
as
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

-- Q7: Cheeses that are aged outside the "standard" aging period

create or replace view Q7(cheese,maker,aged,min_aging,max_aging)
as
SELECT c.name AS cheese, m.name AS maker, c.aged_for AS aged, s.min_aging, s.max_aging 
FROM cheeses c
JOIN makers m ON c.made_by = m.id
JOIN styles s ON c.style = s.id
WHERE c.aged_for < s.min_aging OR c.aged_for > s.max_aging
ORDER BY c.name;

-- Q8: Return a list of cheesemakers matching a partial name, and their location

drop function if exists Q8;
drop type if exists MakerType;
create type MakerType as (maker text, location text);
create or replace function Q8(partial_name text) returns SETOF MakerType as $$
BEGIN
        RETURN QUERY
        SELECT  m.name AS maker,
		TRIM(
			COALESCE(NULLIF(p.town, '') || ', ', '') || 
			COALESCE(NULLIF(p.region, '') || ', ', '') ||
			COALESCE(NULLIF(p.country, ''), '')
		) AS location
        FROM makers m
        JOIN places p ON m.located_in = p.id
        WHERE m.name ILIKE '%' || partial_name || '%'
        ORDER BY m.name;
END;
$$ language plpgsql;

-- Q9: Lists of cheeses for cheesemakers matching a partial name

drop function if exists Q9;
drop type if exists OneCheese;
create type OneCheese as ( maker text, cheese text, style text );
create or replace function Q9(partial_name text)
	returns setof OneCheese
as $$
BEGIN
	RETURN QUERY
	SELECT
		CASE
			WHEN ROW_NUMBER() OVER (PARTITION BY m.name ORDER BY c.name) = 1
				THEN m.name
			ELSE NULL
		END AS maker,
		c.name AS cheese, 
		s.name AS style 
	FROM makers m
	JOIN cheeses c ON c.made_by = m.id
	JOIN styles s ON s.id = c.style
	WHERE m.name ILIKE '%' || partial_name || '%'
	ORDER BY m.name, c.name;
END;
$$ language plpgsql;
