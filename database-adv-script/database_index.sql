-- Index on Users table (frequently used for login and joins)
CREATE INDEX idx_users_email ON Users(email);
CREATE INDEX idx_users_id ON Users(user_id);

-- Index on Bookings table (commonly filtered by user_id and property_id)
CREATE INDEX idx_bookings_user_id ON Bookings(user_id);
CREATE INDEX idx_bookings_property_id ON Bookings(property_id);
CREATE INDEX idx_bookings_date ON Bookings(booking_date);

-- Index on Properties table (frequently searched by location and host_id)
CREATE INDEX idx_properties_location ON Properties(location);
CREATE INDEX idx_properties_host_id ON Properties(host_id);

-- Example of composite index
CREATE INDEX idx_bookings_user_property ON Bookings(user_id, property_id);

-- Performance Check with EXPLAIN ANALYZE
EXPLAIN ANALYZE
SELECT u.first_name, u.last_name, b.booking_date, p.title
FROM Users u
JOIN Bookings b ON u.user_id = b.user_id
JOIN Properties p ON b.property_id = p.property_id
WHERE u.email = 'test@example.com'
ORDER BY b.booking_date DESC;