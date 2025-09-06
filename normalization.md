# Task 1: Database Normalization

## Objective
Apply normalization principles to the AirBnB database design and ensure the schema is in Third Normal Form (3NF).

---

## Step 1: First Normal Form (1NF)
- All attributes are **atomic** (e.g., `email` stores a single value, not multiple emails).
- Each record is uniquely identified by a **primary key** (`user_id`, `property_id`, etc.).

---

## Step 2: Second Normal Form (2NF)
- No table uses a **composite primary key**. 
- All non-key attributes depend on the **whole primary key**.

---

## Step 3: Third Normal Form (3NF)
- No **transitive dependencies** exist (non-key attributes depending on other non-key attributes).
- Example consideration: in `Booking`, `total_price` could be derived from `Property.pricepernight × number_of_nights`. 
  - It is included intentionally for query efficiency, but this is a **denormalization** choice.

---

## Conclusion
The AirBnB schema is fully normalized up to 3NF.  
Where denormalization (e.g., `total_price`) is used, it is justified for performance optimization without breaking integrity.