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
ORDER BY c.name
;

-- Q3: Crumbly cheeses

create or replace view Q3(cheese,maker)
as
SELECT c.name, m.name
FROM cheeses c
JOIN styles s ON c.style = s.id
JOIN makers m ON c.made_by = m.id
WHERE s.notes ILIKE '%crumbly%'
ORDER BY c.name
;

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
;

-- Q6: Country that makes the most styles of cheese

--create or replace view Q6(country)
--as
-- your code here
;

-- Q7: Cheeses that are aged outside the "standard" aging period

--create or replace view Q7(cheese,maker,aged,min_aging,max_aging)
--as
-- your code here
;

-- Q8: Return a list of cheesemakers matching a partial name, and their location

--function if exists Q8;
--drop type if exists MakerPlace;
--create type MakerPlace as ( maker text, location text );

--create or replace function Q8(partial_name text)
--	returns setof MakerPlace
--as $$
-- your code here
--$$ language plpgsql;

-- Q9: Lists of cheeses for cheesemakers matching a partial name

--drop function if exists Q9;
--drop type if exists OneCheese;
--create type OneCheese as ( maker text, cheese text, style text );

--create or replace function Q9(partial_name text)
--	returns setof OneCheese
--as $$
-- your code here
--$$ language plpgsql;
