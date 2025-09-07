
# 🛠️ Airbnb Database Performance Monitoring & Optimization

## 🎯 Objective
Continuously monitor and enhance database performance by analyzing query execution plans, applying indexing strategies, and refining query structures.  
Goal: achieve faster query response times while ensuring scalability for large datasets.

---

## 🔎 Queries Selected for Profiling

To simulate real-world usage, we profiled **five high-frequency queries**:

### 1️⃣ User Authentication Lookup
```sql
SELECT user_id, password_hash
FROM User
WHERE email = 'alice@example.com';
```

### 2️⃣ User’s Recent Bookings
```sql
SELECT booking_id, property_id, start_date, end_date, status, created_at
FROM Booking
WHERE user_id = 'USER-UUID-123'
ORDER BY created_at DESC
LIMIT 20;
```

### 3️⃣ Property Availability Check
```sql
SELECT booking_id
FROM Booking
WHERE property_id = 'PROP-UUID-123'
  AND start_date <= '2025-12-20'
  AND end_date >= '2025-12-15';
```

### 4️⃣ Comprehensive Booking Details
```sql
SELECT b.booking_id, u.first_name, u.last_name, u.email,
       p.name AS property_name, p.location,
       pay.amount, pay.payment_method, pay.payment_date
FROM Booking b
JOIN User u ON u.user_id = b.user_id
JOIN Property p ON p.property_id = b.property_id
LEFT JOIN Payment pay ON pay.booking_id = b.booking_id
ORDER BY b.booking_id ASC
LIMIT 200;
```

### 5️⃣ Ranking Properties by Bookings
```sql
SELECT p.property_id, p.name AS property_name,
       COUNT(b.booking_id) AS total_bookings,
       RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS rank_position
FROM Property p
LEFT JOIN Booking b ON b.property_id = p.property_id
GROUP BY p.property_id, p.name
ORDER BY total_bookings DESC
LIMIT 50;
```

---

## 🧪 Monitoring Methodology

1. Used **`EXPLAIN`** and **`EXPLAIN ANALYZE`** to profile each query.
2. Key metrics observed:
   - **Access type** (`ALL` → bad, `ref`/`eq_ref` → good)
   - **Rows scanned** vs actual rows returned
   - **Index usage** (`key` column)
   - **Presence of `Using temporary` or `Using filesort`** (performance red flags)
3. Queries were measured **before and after optimizations** to quantify improvements.

---

## 🛠️ Performance Refinements

### 1️⃣ Indexing Improvements
| Table | Indexed Columns | Purpose |
|-------|----------------|---------|
| User | email, created_at, role | Fast lookups, filtering, sorting |
| Booking | user_id, created_at | Efficient retrieval of recent bookings |
| Booking | property_id, start_date, end_date | Availability checks, joins |
| Property | location, pricepernight | Filtering & ranking |
| Payment | booking_id | Joins with Booking |

### 2️⃣ Query Refactoring
- Replaced `SELECT *` with only necessary columns.
- Ordered results on indexed columns to avoid `Using filesort`.
- Limited rows using `LIMIT` clauses for high-traffic queries.

### 3️⃣ Table Partitioning
- `Booking` table partitioned by `start_date` (from Task 5) to optimize range queries.

---

## 📈 Observed Improvements

| Query | Before (ms) | After (ms) | Improvement |
|-------|-------------|------------|-------------|
| User login lookup | 118 | 4 | ~97% faster |
| User’s recent bookings | 160 | 10 | ~94% faster |
| Property availability check | 240 | 15 | ~94% faster |
| Complex join (booking + user + property + payment) | 300 | 40 | ~87% faster |
| Ranking properties | 220 | 125 | ~43% faster |

> *Note: Replace these sample timings with your actual results from `EXPLAIN ANALYZE`.*

---

## ✅ Key Takeaways

1. Always profile queries before and after optimization; assumptions can be misleading.
2. Composite indexes aligned with query patterns deliver significant performance improvements.
3. Avoid `SELECT *` in production queries to reduce unnecessary I/O.
4. Combining **partitioning + indexing** ensures scalable performance for large datasets.
5. Performance tuning is **continuous**—monitor regularly as data and query patterns evolve.
