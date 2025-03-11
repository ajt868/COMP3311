CREATE VIEW Q1(maker,founded)
as
SELECT name,founded FROM makers
WHERE founded = (SELECT MIN(founded) FROM makers)
ORDER BY name;
