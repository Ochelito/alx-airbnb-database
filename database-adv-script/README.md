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

# SQL Subqueries

This directory contains SQL scripts practicing **subqueries** in the Airbnb database.

## Queries Implemented

1. **Non-Correlated Subquery**
   - Find all properties where the average rating is greater than 4.0.
   - Uses a subquery on the `Review` table with `GROUP BY` and `HAVING`.

2. **Correlated Subquery**
   - Find users who have made more than 3 bookings.
   - The subquery depends on the outer query (`User.user_id`).
   - Executes once per user row.

## Files
- `subqueries.sql` → SQL commands for non-correlated and correlated subqueries.
- `README.md` → Explanation of each query.


# Aggregations and Window Functions

This directory contains SQL queries demonstrating the use of **aggregations** and **window functions** in the Airbnb database.

## Queries Implemented

1. **Aggregation (COUNT + GROUP BY)**
   - Finds the total number of bookings made by each user.
   - Groups results by user ID, first name, and last name.

2. **Window Function (RANK)**
   - Ranks properties based on the total number of bookings they have received.
   - Uses `RANK() OVER (ORDER BY COUNT(b.booking_id) DESC)` to assign ranks.
   - Properties with the same number of bookings share the same rank.

## Files
- `aggregations_and_window_functions.sql` → SQL commands for aggregation and ranking.
- `README.md` → Explanation of each query.