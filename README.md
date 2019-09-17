# moloco-exercise
code for exercise 

1. 
```sql
SELECT site_id, COUNT(DISTINCT user_id)
FROM moloco
WHERE country_id = 'BDV'
GROUP BY site_id;
```

2. 
```sql
SELECT a.user_id, a.site_id, COUNT(b.site_id) AS numer_of_visits
FROM moloco a
INNER JOIN moloco b
ON a.user_id = b.user_id AND a.site_id = b.site_id AND a.ts = b.ts
WHERE b.ts Between '2019-02-03 00:00:00' and '2019-02-04 23:59:59'
GROUP BY a.user_id, a.site_id
HAVING COUNT(b.site_id) > 10;
```

3. 
```sql
SELECT a.site_id, COUNT(a.user_id) AS number_of_users
FROM moloco a
INNER JOIN (SELECT user_id, MAX(ts) AS ts
		   FROM moloco
		   GROUP BY user_id) b
		   ON a.ts = b.ts AND a.user_id = b.user_id
GROUP BY a.site_id
ORDER BY number_of_users DESC
LIMIT 3;
```

4. 
```sql
SELECT COUNT(*)
FROM
(SELECT user_id, site_id
FROM moloco
WHERE (user_id,ts) in (SELECT user_id, MIN(ts) FROM moloco GROUP BY user_id)) a
INNER JOIN (SELECT user_id, site_id
FROM moloco
WHERE (user_id,ts) in (SELECT user_id, MAX(ts) FROM moloco GROUP BY user_id)) b
ON a.site_id = b.site_id AND a.user_id = b.user_id;
```
