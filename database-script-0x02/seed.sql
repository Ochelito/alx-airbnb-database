-- User table seeding
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
  ('uuid-1', 'Alice', 'Johnson', 'alice@example.com', 'hashed_pw1', '1234567890', 'guest', NOW()),
  ('uuid-2', 'Bob', 'Smith', 'bob@example.com', 'hashed_pw2', '2345678901', 'host', NOW()),
  ('uuid-3', 'Clara', 'Lee', 'clara@example.com', 'hashed_pw3', '3456789012', 'admin', NOW());

-- Property table seeding
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at)
VALUES
  ('uuid-10', 'uuid-2', 'Cozy Apartment', 'A 2-bedroom apartment near city center', 'New York', 120.00, NOW()),
  ('uuid-11', 'uuid-2', 'Beach House', 'A sunny beach house with ocean view', 'Miami', 250.00, NOW());

-- Booking table seeding
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES
  ('uuid-20', 'uuid-10', 'uuid-1', '2025-09-10', '2025-09-15', 600.00, 'confirmed', NOW()),
  ('uuid-21', 'uuid-11', 'uuid-1', '2025-12-20', '2025-12-25', 1250.00, 'pending', NOW());

-- Payment table seeding
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method)
VALUES
  ('uuid-30', 'uuid-20', 600.00, NOW(), 'credit_card');

-- Review table seeding
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at)
VALUES
  ('uuid-40', 'uuid-10', 'uuid-1', 5, 'Amazing apartment, very clean and central!', NOW());

-- Message table seeding
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES
  ('uuid-50', 'uuid-1', 'uuid-2', 'Hi, is the beach house available in December?', NOW()),
  ('uuid-51', 'uuid-2', 'uuid-1', 'Yes, but please confirm the booking soon.', NOW());