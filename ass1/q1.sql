CREATE VIEW Q1(maker,founded)
as
SELECT name,founded FROM makers
ORDER BY founded
FETCH FIRST 1 ROW ONLY;
