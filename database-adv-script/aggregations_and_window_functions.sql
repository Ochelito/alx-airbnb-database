-- 1. Aggregation: Find the total number of bookings made by each user
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM User u
LEFT JOIN Booking b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_bookings DESC;


-- 2. Window Functions: Rank properties based on the total number of bookings
-- We compute the aggregate first, then apply window functions (ROW_NUMBER, RANK)
WITH property_bookings AS (
    SELECT 
        p.property_id,
        p.name AS property_name,
        COUNT(b.booking_id) AS total_bookings
    FROM Property p
    LEFT JOIN Booking b ON p.property_id = b.property_id
    GROUP BY p.property_id, p.name
)
SELECT
    property_id,
    property_name,
    total_bookings,
    -- ROW_NUMBER: unique sequential number (useful for pagination or stable ordering)
    ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS booking_row_number,
    -- RANK: assigns same rank to ties, leaves gaps
    RANK() OVER (ORDER BY total_bookings DESC) AS booking_rank,
    -- DENSE_RANK: assigns same rank to ties, no gaps
    DENSE_RANK() OVER (ORDER BY total_bookings DESC) AS booking_dense_rank
FROM property_bookings
ORDER BY total_bookings DESC;
