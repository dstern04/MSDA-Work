SELECT airports.name, COUNT(dest)
FROM flights
INNER JOIN airports
ON flights.dest = airports.faa
GROUP BY airports.name
ORDER BY COUNT(dest) DESC
LIMIT 5


