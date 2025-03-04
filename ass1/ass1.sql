-- COMP3311 25T1 Assignment 1
--
-- Fill in the gaps ("...") below with your code
--
-- You can add any auxiliary views/function that you like
-- but they must be defined in this file *before* their first use
--
-- The code in this file *MUST* load into an empty database in one pass
--
-- It will be tested as follows:
-- createdb test; psql test -f ass1.dump; psql test -f ass1.sql
--
-- Make sure it can load without error under these conditions

-- Put any views/functions that might be useful in multiple questions here


-- Q1: oldest cheesemaker

create or replace view Q1(maker,founded)
as
SELECT name,founded FROM makers
ORDER BY founded
FETCH FIRST 1 ROW ONLY;

-- Q2: cheese with same name as style
	

create or replace view Q2(cheese,maker)
as
SELECT c.name, m.name
FROM cheeses c
JOIN styles s ON c.style = s.id
JOIN makers m on c.made_by = m.id
WHERE c.name = s.name
ORDER BY c.name;
;
                                                                                                                                                                            
-- INSERT --                                                                                                                                                                 10,17         All
-- Q3: Crumbly cheeses

create or replace view Q3(cheese,maker)
as
SELECT c.name, m.name
FROM cheeses c
JOIN styles s ON c.style = s.id
JOIN makers m on c.made_by = m.id
WHERE s.notes = 'crumbly'
ORDER BY c.name;
-- your code here
;

-- Q4: How many of each hardness level

create or replace view Q4(hardness,ncheeses)
as
-- your code here
;

-- Q5: Most popular cheese style

create or replace view Q5(style)
as
-- your code here
;

-- Q6: Country that makes the most styles of cheese

create or replace view Q6(country)
as
-- your code here
;

-- Q7: Cheeses that are aged outside the "standard" aging period

create or replace view Q7(cheese,maker,aged,min_aging,max_aging)
as
-- your code here
;

