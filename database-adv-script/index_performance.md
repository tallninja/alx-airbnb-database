# Index Performance

**Without Index**
```sql
BEGIN;

	DROP INDEX IF EXISTS "idx_user_email";

	EXPLAIN ANALYZE
	SELECT * FROM users
	WHERE email = 'ernest.wambua@example.com';

ROLLBACK;
```

![without index](without_index.png)


**With Index**

```sql
BEGIN;

	EXPLAIN ANALYZE
	SELECT * FROM users
	WHERE email = 'ernest.wambua@example.com';

ROLLBACK;
```

![with index](with_index.png)
