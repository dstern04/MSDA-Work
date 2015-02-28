library(RPostgreSQL)
library(sqldf)

options(sqldf.RPostgreSQL.user ="postgres", 
        sqldf.RPostgreSQL.password ="temppassword", 
        sqldf.RPostgreSQL.dbname ="flights",
        sqldf.RPostgreSQL.host ="localhost", 
        sqldf.RPostgreSQL.port =5432)

LAflights <-sqldf("SELECT f.origin, f.dest, f.carrier, w.temp, f.dep_delay, f.arr_delay, f.air_time, p.seats, f.month, f.day 
FROM flights AS f
LEFT JOIN planes AS p
ON p.tailnum = f.tailnum
LEFT JOIN weather AS w
ON w.month = f.month AND w.day = f.day AND w.hour = f.hour 
WHERE f.dest = 'LAX'
AND f.month = 2 AND f.day >= 23")

