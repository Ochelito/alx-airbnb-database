# Partitioning Performance Report

## Objective
Implement partitioning on the `Booking` table based on the `start_date` column to optimize queries on large datasets.

## Steps Taken
1. Created a new partitioned table `Booking_partitioned` using RANGE partitioning by year of `start_date`.
2. Copied all existing booking data from `Booking` to `Booking_partitioned`.
3. Tested query performance for fetching bookings in specific date ranges.

## Test Queries
**Before Partitioning**
```sql
EXPLAIN SELECT * FROM Booking WHERE start_date BETWEEN '2022-01-01' AND '2022-12-31';