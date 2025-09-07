-- Step 1: Initial Complex Query (Unoptimized)
-- Retrieves all bookings along with user, property, and payment details
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    u.user_id,
    u.first_name,
    u.last_name,
    p.property_id,
    p.title AS property_title,
    pay.payment_id,
    pay.amount,
    pay.status
FROM Bookings b
JOIN Users u ON b.user_id = u.user_id
JOIN Properties p ON b.property_id = p.property_id
JOIN Payments pay ON b.booking_id = pay.booking_id;

-- Step 2: Analyze Query Performance
-- Use EXPLAIN to analyze execution plan
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    u.user_id,
    u.first_name,
    u.last_name,
    p.property_id,
    p.title AS property_title,
    pay.payment_id,
    pay.amount,
    pay.status
FROM Bookings b
JOIN Users u ON b.user_id = u.user_id
JOIN Properties p ON b.property_id = p.property_id
JOIN Payments pay ON b.booking_id = pay.booking_id;

-- Step 3: Optimized Query
-- Assumes indexes exist on key join/filter columns:
--   Users(user_id), Properties(property_id), Bookings(user_id, property_id), Payments(booking_id)
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    u.user_id,
    u.first_name,
    u.last_name,
    p.property_id,
    p.title AS property_title,
    pay.payment_id,
    pay.amount,
    pay.status
FROM Bookings b
INNER JOIN Users u ON b.user_id = u.user_id
INNER JOIN Properties p ON b.property_id = p.property_id
LEFT JOIN Payments pay ON b.booking_id = pay.booking_id
ORDER BY b.start_date DESC;