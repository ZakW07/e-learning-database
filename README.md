# E-Learning Platform Database

This repository contains the logical design and implementation of a relational database for an e-learning course advisor platform. 

The database was designed and built as part of a group project at Heriot-Watt University.

## Features
- **Schema Design:** Implements a robust relational schema with independent tables (User, Category, Provider, Instructor), dependent tables (Course, Review), and linking tables for many-to-many relationships (CourseCategory, CourseInstructor).
- **Data Integrity:** Utilizes primary keys, foreign keys, constraints (e.g., review ratings between 1 and 10), and auto-incrementing IDs.
- **Complex Querying:** Includes multi-table `JOIN` operations, aggregate functions (`SUM`, `AVG`, `COUNT`), filtering (`WHERE IN`), and derived attribute calculations.

## Files
- `database.sql`: Contains the complete SQL script to create the schema, populate the database with sample data, and run analytical queries.

## Example Queries Included
- Calculating the average review rating for every course (derived attribute).
- Aggregating the total price of courses offered by specific providers.
- Finding the most popular course categories using `JOIN` and `GROUP BY`.
