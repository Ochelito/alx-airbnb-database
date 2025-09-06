# SQL Joins Queries

This directory contains SQL queries demonstrating the use of different types of **joins** in the Airbnb database.

## Queries Implemented

1. **INNER JOIN**
   - Retrieves all bookings and the respective users who made those bookings.

2. **LEFT JOIN**
   - Retrieves all properties and their reviews, including properties that have no reviews.

3. **FULL OUTER JOIN**
   - Retrieves all users and all bookings, even if the user has no booking or a booking is not linked to a user.
   - Note: `FULL OUTER JOIN` is supported in PostgreSQL.  
     For MySQL, simulate it using:
     ```sql
     SELECT u.user_id, u.first_name, u.last_name, b.booking_id, b.start_date, b.end_date
     FROM User u
     LEFT JOIN Booking b ON u.user_id = b.user_id
     UNION
     SELECT u.user_id, u.first_name, u.last_name, b.booking_id, b.start_date, b.end_date
     FROM User u
     RIGHT JOIN Booking b ON u.user_id = b.user_id;
     ```

## Files
- `joins_queries.sql` → SQL commands for the joins
- `README.md` → Explanation of each query