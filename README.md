# 📦 Courier Tracking System

## 📌 Project Overview

The **Courier Tracking System** is a MySQL-based SQL project created to analyze courier operations, shipments, customers, courier partners, branches, employees, payments, tracking events, delivery attempts, and customer feedback.

This project focuses on practical SQL analysis using a relational database with **10 tables** and SQL queries ranging from basic filtering to advanced analytical techniques.

---

## 🎯 Project Objectives

- Create a relational database for a courier tracking system.
- Create tables with primary keys and foreign key relationships.
- Verify and validate the imported data.
- Analyze shipments and customers using SQL.
- Calculate shipment counts and shipping revenue.
- Analyze courier partner performance.
- Find customers with high shipment activity.
- Use subqueries and CTEs for advanced analysis.
- Apply window functions for ranking and top-N analysis.
- Solve practical business questions using SQL.

---

## 🗄️ Database

**Database Name:** `courier_tracking_system`

The database contains the following 10 tables:

| Table | Description |
|---|---|
| `customers` | Stores customer details |
| `courier_partners` | Stores courier partner information and ratings |
| `branches` | Stores branch details and capacity |
| `employees` | Stores employee details and branch assignments |
| `shipments` | Stores shipment and delivery information |
| `shipment_items` | Stores items associated with shipments |
| `tracking_events` | Stores shipment tracking events |
| `delivery_attempts` | Stores delivery attempt details |
| `payments` | Stores shipment payment information |
| `feedback` | Stores customer ratings and feedback |

---

## 🔗 Database Relationships

```text
Customers
    │
    └── Shipments
          │
          ├── Courier Partners
          ├── Origin Branch
          ├── Destination Branch
          ├── Shipment Items
          ├── Tracking Events
          ├── Delivery Attempts
          ├── Payments
          └── Feedback

Branches
    │
    └── Employees
```


🛠️ Tools Used
- MySQL
- MySQL Workbench
- SQL
- GitHub
📊 SQL Concepts Covered
1. Database & Table Creation
The project creates the courier_tracking_system database and 10 related tables using:
- Primary Keys
- Foreign Keys
- Data Types
- NOT NULL
- CHECK constraints
2. Data Verification
The project includes queries for:
- Viewing all tables using SHOW TABLES
- Viewing table records using SELECT *
- Counting records across all 10 tables
3. Data Validation
The project includes NULL-value validation for:
- Customers
- Courier Partners
- Branches
- Employees
- Shipments
These checks help verify the quality and completeness of the imported data.
4. WHERE Clause
The project includes queries for:
- Delivered shipments
- Shipments with shipping cost greater than ₹1,000
- Shipments weighing more than 5 kg
- Express shipments
- Delayed or returned shipments
- Customers from Chennai
- Delivery agents
- Shipments booked between January and March 2025
5. GROUP BY
The project analyzes:
- Number of shipments by status
- Number of shipments by service type
- Total revenue by service type
- Average shipping cost by service type
- Customers by city
- Employees by role
- Total payment by payment method
- Average rating by feedback category
6. Aggregate Functions
The project uses:
COUNT()
SUM()
AVG()

for:
- Shipment counts
- Shipping revenue
- Average shipping cost
- Payment totals
- Customer ratings
7. HAVING
The project uses HAVING to filter grouped results, including:
- Service types with more than 1,000 shipments
- Cities with more than 300 customers
8. JOINS
The project demonstrates joins between related tables.
Examples include:
- Shipments + Customers
- Shipments + Courier Partners
9. Subqueries
The project includes subqueries for:
- Finding shipments above the average shipping cost
- Finding customers with more shipments than the average customer
10. Common Table Expressions (CTEs)
The project uses WITH clauses for:
- Customers with more than 5 shipments
- Finding the courier partner with the highest revenue
- Finding service types with average shipping cost above ₹500
11. Window Functions
The project uses:
ROW_NUMBER()
RANK()

for:
- Ranking shipments by shipping cost
- Finding the top 3 expensive shipments for each service type
- Ranking courier partners by rating
- Ranking courier partners by revenue
📈 Business Analysis
The SQL queries answer practical courier business questions such as:
- Which shipments have been delivered?
- Which shipments have a shipping cost above ₹1,000?
- Which shipments weigh more than 5 kg?
- How many shipments belong to each service type?
- Which service types generate the highest revenue?
- Which cities have more than 300 customers?
- Which courier partner generates the highest revenue?
- Which service types have an average shipping cost above ₹500?
- What are the top 3 expensive shipments for each service type?
- How are courier partners ranked by rating?
- How are courier partners ranked by revenue?
💻 Sample SQL Queries
Total Shipments
SELECT COUNT(*) AS total_shipments
FROM shipments;

Total Shipping Revenue
SELECT SUM(shipping_cost) AS total_revenue
FROM shipments;

Shipments by Status
SELECT
    shipment_status,
    COUNT(*) AS total_shipments
FROM shipments
GROUP BY shipment_status;

Shipments Above Average Shipping Cost
SELECT *
FROM shipments
WHERE shipping_cost > (
    SELECT AVG(shipping_cost)
    FROM shipments
);

Top 3 Expensive Shipments per Service Type
WITH ranked_shipments AS (
    SELECT
        shipment_id,
        service_type,
        shipping_cost,
        ROW_NUMBER() OVER (
            PARTITION BY service_type
            ORDER BY shipping_cost DESC
        ) AS rn
    FROM shipments
)
SELECT *
FROM ranked_shipments
WHERE rn <= 3;

Courier Ranking by Revenue
WITH courier_performance AS (
    SELECT
        cp.partner_id,
        cp.partner_name,
        COUNT(s.shipment_id) AS total_shipments,
        SUM(s.shipping_cost) AS total_revenue,
        AVG(cp.rating) AS average_rating
    FROM courier_partners cp
    JOIN shipments s
        ON cp.partner_id = s.partner_id
    GROUP BY
        cp.partner_id,
        cp.partner_name
)
SELECT
    partner_id,
    partner_name,
    total_shipments,
    total_revenue,
    average_rating,
    RANK() OVER (
        ORDER BY total_revenue DESC
    ) AS revenue_rank
FROM courier_performance
ORDER BY revenue_rank;
