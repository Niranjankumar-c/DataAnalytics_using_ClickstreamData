USE alabs_db;



--create view for analysis



CREATE VIEW omniture AS

SELECT COL_2 TIMESTAMP,

COL_8 IPADDRESS,

COL_13 URL,

COL_14 SW_ID,

COL_50 CITY,

COL_51 COUNTRY,

COL_53 STATE

FROM omniturelogs;



--create final table for analysis



CREATE TABLE webloganalytics AS

SELECT TO_DATE(o.timestamp) logdate,

o.url url,

o.ipaddress ipaddress,

o.city city,

UPPER(o.state) state,

o.country country,

p.category category,

CAST(DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),
FROM_UNIXTIME(UNIX_TIMESTAMP(u.birth_dt,'dd-MMM-yy')))/365 AS INT) age,

u.gender_cd gender_cd

FROM omniture o

INNER JOIN products p

ON o.url = p.url

LEFT OUTER JOIN users u

ON o.sw_id = CONCAT('{',u.sw_id,'}');

--end
