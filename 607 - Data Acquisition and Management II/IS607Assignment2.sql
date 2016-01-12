SELECT name FROM airports
INNER JOIN flights
ON flights.dest = airports.faa
ORDER BY distance DESC
LIMIT 1;

SELECT engines, max(seats) AS seats
FROM planes
GROUP BY engines
ORDER BY engines ASC;

SELECT DISTINCT b.engines, b.seats, b.manufacturer, b.model
FROM (SELECT engines, max(seats) AS seats FROM planes GROUP BY engines
) AS a inner join planes AS b on b.engines = a.engines AND b.seats = a.seats
ORDER BY engines ASC;

SELECT 
corr(weather.visib,flights.dep_delay)"visib R",
corr(weather.wind_gust,flights.dep_delay)"wind gust R",
corr(weather.temp,flights.dep_delay)"temp R",
corr(weather.dewp,flights.dep_delay)"dewp R",
corr(weather.humid,flights.dep_delay)"humid R",
corr(weather.wind_speed,flights.dep_delay)"wind speed R",
corr(weather.precip,flights.dep_delay)"precip R",
corr(weather.pressure,flights.dep_delay)"pressure R"
FROM flights 
LEFT JOIN weather 
ON flights.origin = weather.origin 
AND flights.year = weather.year 
AND flights.month = weather.month 
AND flights.day = weather.day 
AND flights.hour = weather.hour
WHERE dep_delay >= 0;

SELECT corr(flights.dep_delay,2014-planes.year)"age, delay R"
FROM flights
INNER JOIN planes
ON flights.tailnum = planes.tailnum
WHERE dep_delay >= 0;

SELECT a.name, COUNT (*) "delays"
FROM flights "f"
RIGHT JOIN airlines "a"
ON a.carrier = f.carrier
WHERE f.dep_delay >= 0
GROUP BY a.name
ORDER BY delays DESC
LIMIT 1;



