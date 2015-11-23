SELECT a.name, a.lat, b.name, b.lat
FROM airports a, airports b
WHERE a.lat > (
SELECT lat
FROM airports
WHERE name = 'Fairbanks Intl')
AND b.lat > a.lat
ORDER BY a.name, b.lat DESC