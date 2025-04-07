create or replace view JohnFavouriteBeer(brewer, beer) AS
select beer.name, brewer.name from beer
JOIN ratings ON ratings.beer = beer.id
JOIN taster ON ratings.taster = taster.id
JOIN brewer ON brewer.id = beer.brewer
WHERE taster.given = 'John'
ORDER BY ratings.score;
