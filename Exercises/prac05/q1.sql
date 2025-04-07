create or replace view AllRatings(taster, beer, brewer, rating) AS
select taster.given AS taster, beer.name as beer, brewer.name AS brewer, ratings.score as rating FROM ratings
JOIN beer ON beer.id = ratings.beer
JOIN taster ON taster.id = ratings.taster
JOIN brewer ON brewer.id = beer.brewer
ORDER BY taster;
