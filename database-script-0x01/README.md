# Database Schema - AirBnB Clone

## Overview
This directory contains the SQL schema definition for the AirBnB database project.

## Files
- **schema.sql**: Defines all database tables, primary keys, foreign keys, constraints, and indexes.

## Schema Highlights
- **User**: Stores user information (guest, host, admin).
- **Property**: Stores property details hosted by users.
- **Booking**: Stores booking details between users and properties.
- **Payment**: Stores payment details linked to bookings.
- **Review**: Stores reviews users leave on properties.
- **Message**: Stores direct messages between users.

## Constraints
- Primary keys on all tables (UUID).
- Foreign key constraints enforce relationships.
- Unique constraint on `User.email`.
- ENUMs represented using `CHECK` constraints.
- Rating must be between 1–5.

## Indexing
- Automatic indexing on primary keys.
- Additional indexes:
  - `User.email`
  - `Property.property_id`
  - `Booking.property_id`
  - `Booking.booking_id`
  - `Payment.booking_id`