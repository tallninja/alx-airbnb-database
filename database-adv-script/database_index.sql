-- Without index
BEGIN;

	DROP INDEX IF EXISTS "idx_user_email";

	EXPLAIN ANALYZE
	SELECT * FROM users
	WHERE email = 'ernest.wambua@example.com';

ROLLBACK;

-- With index
BEGIN;

	EXPLAIN ANALYZE
	SELECT * FROM users
	WHERE email = 'ernest.wambua@example.com';

ROLLBACK;