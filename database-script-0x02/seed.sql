-- Insert locations
INSERT INTO locations (location_id, country, state, city, postal_code, lat, lng) VALUES
    (uuid_generate_v4(), 'United States', 'California', 'San Francisco', '94110', 37.7749, -122.4194),
    (uuid_generate_v4(), 'United States', 'New York', 'New York City', '10001', 40.7128, -74.0060),
    (uuid_generate_v4(), 'United Kingdom', 'England', 'London', 'SW1A 1AA', 51.5074, -0.1278),
    (uuid_generate_v4(), 'France', 'Île-de-France', 'Paris', '75001', 48.8566, 2.3522),
    (uuid_generate_v4(), 'Japan', 'Tokyo', 'Tokyo', '100-0005', 35.6762, 139.6503);

-- Insert users with different roles
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
    (uuid_generate_v4(), 'John', 'Doe', 'john.doe@example.com', 'hashed_password_1', '+1234567890', 'host'),
    (uuid_generate_v4(), 'Jane', 'Smith', 'jane.smith@example.com', 'hashed_password_2', '+9876543210', 'guest'),
    (uuid_generate_v4(), 'Alice', 'Johnson', 'alice.johnson@example.com', 'hashed_password_3', '+1122334455', 'host'),
    (uuid_generate_v4(), 'Bob', 'Williams', 'bob.williams@example.com', 'hashed_password_4', '+5544332211', 'guest'),
    (uuid_generate_v4(), 'Emma', 'Brown', 'emma.brown@example.com', 'hashed_password_5', '+9988776655', 'admin');

-- Insert properties (linking to hosts and locations)
WITH host_locations AS (
    SELECT 
        (SELECT user_id FROM users WHERE first_name = 'John' AND last_name = 'Doe') AS host_id,
        (SELECT location_id FROM locations WHERE city = 'San Francisco') AS location_id
    UNION ALL
    SELECT 
        (SELECT user_id FROM users WHERE first_name = 'Alice' AND last_name = 'Johnson') AS host_id,
        (SELECT location_id FROM locations WHERE city = 'New York City') AS location_id
)
INSERT INTO properties (property_id, host_id, name, description, location, pricepernight) VALUES
    (uuid_generate_v4(), 
     (SELECT host_id FROM host_locations WHERE city = 'San Francisco'), 
     'Cozy SF Loft', 
     'Beautiful downtown loft with amazing city views', 
     (SELECT location_id FROM host_locations WHERE city = 'San Francisco'), 
     250.00),
    (uuid_generate_v4(), 
     (SELECT host_id FROM host_locations WHERE city = 'New York City'), 
     'Manhattan Studio Apartment', 
     'Modern studio in the heart of Manhattan', 
     (SELECT location_id FROM host_locations WHERE city = 'New York City'), 
     350.00),
    (uuid_generate_v4(), 
     (SELECT host_id FROM users WHERE first_name = 'John' AND last_name = 'Doe'), 
     'Ocean View Condo', 
     'Spacious condo with panoramic ocean views', 
     (SELECT location_id FROM locations WHERE city = 'San Francisco'), 
     400.00);

-- Insert bookings
WITH property_users AS (
    SELECT 
        (SELECT property_id FROM properties WHERE name = 'Cozy SF Loft') AS property_id,
        (SELECT user_id FROM users WHERE first_name = 'Jane' AND last_name = 'Smith') AS user_id
    UNION ALL
    SELECT 
        (SELECT property_id FROM properties WHERE name = 'Manhattan Studio Apartment') AS property_id,
        (SELECT user_id FROM users WHERE first_name = 'Bob' AND last_name = 'Williams') AS user_id
)
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status) VALUES
    (uuid_generate_v4(), 
     (SELECT property_id FROM property_users WHERE name = 'Cozy SF Loft'), 
     (SELECT user_id FROM property_users WHERE name = 'Cozy SF Loft'), 
     '2024-07-15', '2024-07-20', 1250.00, 'confirmed'),
    (uuid_generate_v4(), 
     (SELECT property_id FROM property_users WHERE name = 'Manhattan Studio Apartment'), 
     (SELECT user_id FROM property_users WHERE name = 'Manhattan Studio Apartment'), 
     '2024-08-01', '2024-08-05', 1750.00, 'pending');

-- Insert payments
WITH booking_details AS (
    SELECT 
        (SELECT booking_id FROM bookings WHERE start_date = '2024-07-15') AS booking_id,
        1250.00 AS amount
    UNION ALL
    SELECT 
        (SELECT booking_id FROM bookings WHERE start_date = '2024-08-01') AS booking_id,
        1750.00 AS amount
)
INSERT INTO payments (payment_id, booking_id, amount, payment_method) VALUES
    (uuid_generate_v4(), 
     (SELECT booking_id FROM booking_details WHERE amount = 1250.00), 
     1250.00, 'credit_card'),
    (uuid_generate_v4(), 
     (SELECT booking_id FROM booking_details WHERE amount = 1750.00), 
     1750.00, 'paypal');

-- Insert reviews
WITH property_user_details AS (
    SELECT 
        (SELECT property_id FROM properties WHERE name = 'Cozy SF Loft') AS property_id,
        (SELECT user_id FROM users WHERE first_name = 'Jane' AND last_name = 'Smith') AS user_id
    UNION ALL
    SELECT 
        (SELECT property_id FROM properties WHERE name = 'Manhattan Studio Apartment') AS property_id,
        (SELECT user_id FROM users WHERE first_name = 'Bob' AND last_name = 'Williams') AS user_id
)
INSERT INTO reviews (review_id, property_id, user_id, rating, comment) VALUES
    (uuid_generate_v4(), 
     (SELECT property_id FROM property_user_details WHERE name = 'Cozy SF Loft'), 
     (SELECT user_id FROM property_user_details WHERE name = 'Cozy SF Loft'), 
     4, 'Great stay, very comfortable and clean!'),
    (uuid_generate_v4(), 
     (SELECT property_id FROM property_user_details WHERE name = 'Manhattan Studio Apartment'), 
     (SELECT user_id FROM property_user_details WHERE name = 'Manhattan Studio Apartment'), 
     5, 'Perfect location and amazing amenities!');

-- Insert messages
WITH sender_recipient AS (
    SELECT 
        (SELECT user_id FROM users WHERE first_name = 'Jane' AND last_name = 'Smith') AS sender_id,
        (SELECT user_id FROM users WHERE first_name = 'John' AND last_name = 'Doe') AS recipient_id
    UNION ALL
    SELECT 
        (SELECT user_id FROM users WHERE first_name = 'Bob' AND last_name = 'Williams') AS sender_id,
        (SELECT user_id FROM users WHERE first_name = 'Alice' AND last_name = 'Johnson') AS recipient_id
)
INSERT INTO messages (message_id, sender_id, recipient_id, message_body) VALUES
    (uuid_generate_v4(), 
     (SELECT sender_id FROM sender_recipient WHERE first_name = 'Jane'), 
     (SELECT recipient_id FROM sender_recipient WHERE first_name = 'Jane'), 
     'Hi, I have a question about the booking.'),
    (uuid_generate_v4(), 
     (SELECT sender_id FROM sender_recipient WHERE first_name = 'Bob'), 
     (SELECT recipient_id FROM sender_recipient WHERE first_name = 'Bob'), 
     'Can you provide more details about the property?');
