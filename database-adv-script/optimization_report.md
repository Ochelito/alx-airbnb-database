# Query Optimization Report

## Initial Query
We wrote a query to retrieve **all bookings with user details, property details, and payment details** using multiple joins.

### Issues Identified
- **Unnecessary FULL JOINs**: All joins were INNER JOIN, meaning if a payment record didn’t exist, the booking would not show up.
- **No Ordering**: The query retrieved results without an order, which could be inefficient for large datasets if sorting is later applied.
- **Indexes Missing**: Without proper indexes, joins required full table scans, leading to high execution costs.

## Optimization Steps
1. **Indexing**
   - Added indexes on high-usage columns:
     - `Users(user_id)`
     - `Properties(property_id)`
     - `Bookings(user_id, property_id)`
     - `Payments(booking_id)`

2. **Join Adjustment**
   - Changed the join with `Payments` to a **LEFT JOIN** to ensure bookings without payments still appear.

3. **Efficient Ordering**
   - Added `ORDER BY b.start_date DESC` to leverage indexes and improve usability.

## Performance Results
- The `EXPLAIN ANALYZE` output showed reduced cost estimates and faster execution time after:
  - **Indexing** (fewer sequential scans).
  - **Left join refactor** (avoids unnecessary filtering).
  - **Ordering with indexed column** (improves query plan efficiency).

✅ Optimized query now executes with **fewer I/O operations** and scales better with large datasets.