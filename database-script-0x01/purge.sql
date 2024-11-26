DROP INDEX IF EXISTS "idx_user_email";

DROP INDEX IF EXISTS "idx_property_location";

DROP INDEX IF EXISTS "idx_property_host";

DROP INDEX IF EXISTS "idx_booking_guest";

DROP INDEX IF EXISTS "idx_booking_property";

DROP INDEX IF EXISTS "idx_payment_booking";

DROP TABLE IF EXISTS "reviews";

DROP TABLE IF EXISTS "messages";

DROP TABLE IF EXISTS "payments";

DROP TABLE IF EXISTS "bookings";

DROP TABLE IF EXISTS "properties";

DROP TABLE IF EXISTS "locations";

DROP TABLE IF EXISTS "users";

DROP TYPE IF EXISTS "role";

DROP TYPE IF EXISTS "booking_status";

DROP TYPE IF EXISTS "payment_method";