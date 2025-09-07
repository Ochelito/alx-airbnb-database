-- ============================================
-- File: database-adv-script/perfomance.sql
-- Goal: Retrieve all bookings with user, property,
--       and payment details, analyze & optimize.
-- ============================================

/* =========================================================
   STEP 1 — Initial Complex Query (Unoptimized)
   Issues:
   - SELECT * would be too heavy (avoid in production)
   - No filters (returns everything)
   - INNER JOIN drops unpaid bookings
   ========================================================= */
SELECT 
  b.booking_id,
  b.start_date,
  b.end_date,
  u.user_id,
  u.first_name,
  u.last_name,
  p.property_id,
  p.name AS property_name,
  pay.payment_id,
  pay.amount,
  pay.payment_method
FROM Booking b
JOIN "User" u
  ON b.user_id = u.user_id
JOIN Property p
  ON b.property_id = p.property_id
JOIN Payment pay
  ON b.booking_id = pay.booking_id
-- Example filter added for validation:
WHERE b.status = 'confirmed' AND pay.amount > 0;


/* =========================================================
   STEP 2 — Analyze Query Performance
   ========================================================= */
EXPLAIN ANALYZE
SELECT 
  b.booking_id,
  b.start_date,
  b.end_date,
  u.user_id,
  u.first_name,
  u.last_name,
  p.property_id,
  p.name AS property_name,
  pay.payment_id,
  pay.amount,
  pay.payment_method
FROM Booking b
JOIN "User" u
  ON b.user_id = u.user_id
JOIN Property p
  ON b.property_id = p.property_id
JOIN Payment pay
  ON b.booking_id = pay.booking_id
WHERE b.status = 'confirmed' AND pay.amount > 0;


/* =========================================================
   STEP 3 — Optimized Query
   Improvements:
   - Specific columns only
   - LEFT JOIN Payment keeps unpaid bookings
   - WHERE + AND filters still apply
   - ORDER BY for deterministic results
   ========================================================= */
SELECT 
  b.booking_id,
  b.start_date,
  b.end_date,
  u.user_id,
  u.first_name,
  u.last_name,
  p.property_id,
  p.name AS property_name,
  pay.payment_id,
  pay.amount,
  pay.payment_method
FROM Booking b
JOIN "User" u
  ON b.user_id = u.user_id
JOIN Property p
  ON b.property_id = p.property_id
LEFT JOIN Payment pay
  ON b.booking_id = pay.booking_id
WHERE b.status = 'confirmed' AND (pay.amount > 0 OR pay.payment_id IS NULL)
ORDER BY b.start_date DESC;


/* =========================================================
   STEP 4 — EXPLAIN Optimized
   ========================================================= */
EXPLAIN ANALYZE
SELECT 
  b.booking_id,
  b.start_date,
  b.end_date,
  u.user_id,
  u.first_name,
  u.last_name,
  p.property_id,
  p.name AS property_name,
  pay.payment_id,
  pay.amount,
  pay.payment_method
FROM Booking b
JOIN "User" u
  ON b.user_id = u.user_id
JOIN Property p
  ON b.property_id = p.property_id
LEFT JOIN Payment pay
  ON b.booking_id = pay.booking_id
WHERE b.status = 'confirmed' AND (pay.amount > 0 OR pay.payment_id IS NULL)
ORDER BY b.start_date DESC;