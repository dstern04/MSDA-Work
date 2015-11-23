SELECT DISTINCT name
FROM flights
INNER JOIN airports
ON flights.dest = airports.faa
WHERE flights.carrier = 'AA'
ORDER BY name ASC