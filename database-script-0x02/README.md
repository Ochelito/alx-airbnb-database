# Database Seeding - AirBnB Clone

## Objective
This script populates the AirBnB database with sample data for testing and demonstration.

## Seeded Data
- **Users**: 3 (Guest, Host, Admin)
- **Properties**: 2 (Cozy Apartment, Beach House)
- **Bookings**: 2 (one confirmed, one pending)
- **Payments**: 1 (linked to a confirmed booking)
- **Reviews**: 1 (guest review of an apartment)
- **Messages**: 2 (guest-host conversation)

## Usage
Run the seed script after creating your schema:

```on bash
mysql -u root -p airbnb_clone < seed.sql