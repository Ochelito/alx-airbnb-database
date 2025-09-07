-- File: partitioning.sql
-- Objective: Partition Booking table by start_date for performance optimization

-- Step 1: Create a new partitioned table
CREATE TABLE Booking_partitioned (
    booking_id INT NOT NULL,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    amount DECIMAL(10,2),
    status VARCHAR(50),
    PRIMARY KEY (booking_id, start_date)
)
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2019 VALUES LESS THAN (2020),
    PARTITION p2020 VALUES LESS THAN (2021),
    PARTITION p2021 VALUES LESS THAN (2022),
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION pmax VALUES LESS THAN MAXVALUE
);

-- Step 2: Copy existing data into the partitioned table
INSERT INTO Booking_partitioned
SELECT * FROM Booking;

-- Step 3: Optional - verify data
SELECT COUNT(*) AS total_bookings FROM Booking_partitioned;

-- Step 4: Example query to test performance
-- Fetch bookings in a date range
EXPLAIN SELECT * 
FROM Booking_partitioned 
WHERE start_date BETWEEN '2022-01-01' AND '2022-12-31';