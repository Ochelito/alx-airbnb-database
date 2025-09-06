# Index Performance Documentation

This file explains the indexing strategy applied to the **Airbnb Database** and the resulting performance improvements.

## 1. Identified High-Usage Columns
- **Users table**: `email`, `user_id`
- **Bookings table**: `user_id`, `property_id`, `booking_date`
- **Properties table**: `location`, `host_id`

These columns are frequently used in `WHERE`, `JOIN`, and `ORDER BY` clauses, making them good candidates for indexing.

## 2. Index Creation
Indexes created in [`database_index.sql`](./database_index.sql):

- `idx_users_email`, `idx_users_id`
- `idx_bookings_user_id`, `idx_bookings_property_id`, `idx_bookings_date`
- `idx_properties_location`, `idx_properties_host_id`
- Composite: `idx_bookings_user_property`

## 3. Performance Measurement
We measured query performance using `EXPLAIN ANALYZE`.

### Example Query (Before Indexing)
```sql
EXPLAIN ANALYZE
SELECT u.first_name, u.last_name, b.booking_date, p.title
FROM Users u
JOIN Bookings b ON u.user_id = b.user_id
JOIN Properties p ON b.property_id = p.property_id
WHERE u.email = 'test@example.com'
ORDER BY b.booking_date DESC;