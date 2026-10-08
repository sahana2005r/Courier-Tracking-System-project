CREATE DATABASE courier_tracking_system;

USE courier_tracking_system;
  
CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150),
    phone VARCHAR(20),
    city VARCHAR(50),
    state VARCHAR(50),
    customer_type VARCHAR(20),
    registration_date DATE
);

CREATE TABLE courier_partners (
    partner_id VARCHAR(20) PRIMARY KEY,
    partner_name VARCHAR(100) NOT NULL,
    partner_type VARCHAR(30),
    rating DECIMAL(3,2),
    contact_email VARCHAR(150),
    service_level VARCHAR(30),
    active_flag VARCHAR(5)
);

CREATE TABLE branches (
    branch_id VARCHAR(20) PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    state VARCHAR(50),
    pincode INT,
    branch_type VARCHAR(30),
    capacity_per_day INT,
    manager_name VARCHAR(100)
);

CREATE TABLE employees (
    employee_id VARCHAR(20) PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    branch_id VARCHAR(20),
    role VARCHAR(50),
    hire_date DATE,
    employment_status VARCHAR(20),
    monthly_salary DECIMAL(10,2),

    FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id)
);

CREATE TABLE shipments (
    shipment_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    partner_id VARCHAR(20),
    origin_branch_id VARCHAR(20),
    destination_branch_id VARCHAR(20),
    booking_date DATE,
    service_type VARCHAR(30),
    package_type VARCHAR(30),
    weight_kg DECIMAL(10,2),
    distance_km INT,
    shipping_cost DECIMAL(10,2),
    shipment_status VARCHAR(30),
    expected_delivery_date DATE,
    actual_delivery_date DATE,

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (partner_id)
        REFERENCES courier_partners(partner_id),

    FOREIGN KEY (origin_branch_id)
        REFERENCES branches(branch_id),

    FOREIGN KEY (destination_branch_id)
        REFERENCES branches(branch_id)
);

CREATE TABLE shipment_items (
    item_id VARCHAR(20) PRIMARY KEY,
    shipment_id VARCHAR(20),
    item_category VARCHAR(50),
    item_description VARCHAR(100),
    quantity INT,
    declared_value DECIMAL(12,2),
    fragile_flag VARCHAR(5),

    FOREIGN KEY (shipment_id)
        REFERENCES shipments(shipment_id)
);

CREATE TABLE tracking_events (
    event_id VARCHAR(20) PRIMARY KEY,
    shipment_id VARCHAR(20),
    branch_id VARCHAR(20),
    employee_id VARCHAR(20),
    event_type VARCHAR(50),
    event_timestamp DATETIME,
    remarks VARCHAR(255),

    FOREIGN KEY (shipment_id)
        REFERENCES shipments(shipment_id),

    FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id),

    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
);

CREATE TABLE delivery_attempts (
    attempt_id VARCHAR(20) PRIMARY KEY,
    shipment_id VARCHAR(20),
    employee_id VARCHAR(20),
    attempt_date DATE,
    attempt_number INT,
    attempt_status VARCHAR(50),
    delivery_lat DECIMAL(10,6),
    delivery_long DECIMAL(10,6),

    FOREIGN KEY (shipment_id)
        REFERENCES shipments(shipment_id),

    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
);

CREATE TABLE payments (
    payment_id VARCHAR(20) PRIMARY KEY,
    shipment_id VARCHAR(20),
    payment_date DATE,
    payment_method VARCHAR(50),
    amount DECIMAL(12,2),
    payment_status VARCHAR(30),
    transaction_reference VARCHAR(50),

    FOREIGN KEY (shipment_id)
        REFERENCES shipments(shipment_id)
);

CREATE TABLE feedback (
    feedback_id VARCHAR(20) PRIMARY KEY,
    shipment_id VARCHAR(20),
    customer_id VARCHAR(20),
    feedback_date DATE,
    rating INT,
    feedback_category VARCHAR(50),
    comments VARCHAR(255),

    FOREIGN KEY (shipment_id)
        REFERENCES shipments(shipment_id),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    CHECK (rating BETWEEN 1 AND 5)
);

SHOW TABLES;


SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';

select * from branches;
select * from courier_partners;
select * from customers;
select * from employees;
select * from shipments;
select * from shipment_items;
select * from tracking_events;
select * from delivery_attempts;
select * from payments;
select * from feedback;

SELECT 'branches' AS table_name, COUNT(*) AS total_rows FROM branches
UNION ALL
SELECT 'courier_partners', COUNT(*) FROM courier_partners
UNION ALL
SELECT 'customers', COUNT(*) FROM customers
UNION ALL
SELECT 'employees', COUNT(*) FROM employees
UNION ALL
SELECT 'shipments', COUNT(*) FROM shipments
UNION ALL
SELECT 'shipment_items', COUNT(*) FROM shipment_items
UNION ALL
SELECT 'tracking_events', COUNT(*) FROM tracking_events
UNION ALL
SELECT 'delivery_attempts', COUNT(*) FROM delivery_attempts
UNION ALL
SELECT 'payments', COUNT(*) FROM payments
UNION ALL
SELECT 'feedback', COUNT(*) FROM feedback;



#DATA VALIDATION------

SELECT
    SUM(customer_id IS NULL) AS customer_id_nulls,
    SUM(customer_name IS NULL) AS customer_name_nulls,
    SUM(email IS NULL) AS email_nulls,
    SUM(phone IS NULL) AS phone_nulls,
    SUM(city IS NULL) AS city_nulls,
    SUM(state IS NULL) AS state_nulls,
    SUM(customer_type IS NULL) AS customer_type_nulls,
    SUM(registration_date IS NULL) AS registration_date_nulls
FROM customers;

SELECT
    SUM(partner_id IS NULL) AS partner_id_nulls,
    SUM(partner_name IS NULL) AS partner_name_nulls,
    SUM(partner_type IS NULL) AS partner_type_nulls,
    SUM(rating IS NULL) AS rating_nulls,
    SUM(contact_email IS NULL) AS email_nulls,
    SUM(service_level IS NULL) AS service_level_nulls,
    SUM(active_flag IS NULL) AS active_flag_nulls
FROM courier_partners;

SELECT
    SUM(branch_id IS NULL) AS branch_id_nulls,
    SUM(branch_name IS NULL) AS branch_name_nulls,
    SUM(city IS NULL) AS city_nulls,
    SUM(state IS NULL) AS state_nulls,
    SUM(pincode IS NULL) AS pincode_nulls,
    SUM(branch_type IS NULL) AS branch_type_nulls,
    SUM(capacity_per_day IS NULL) AS capacity_nulls,
    SUM(manager_name IS NULL) AS manager_name_nulls
FROM branches;

SELECT
    SUM(employee_id IS NULL) AS employee_id_nulls,
    SUM(employee_name IS NULL) AS employee_name_nulls,
    SUM(branch_id IS NULL) AS branch_id_nulls,
    SUM(role IS NULL) AS role_nulls,
    SUM(hire_date IS NULL) AS hire_date_nulls,
    SUM(employment_status IS NULL) AS status_nulls,
    SUM(monthly_salary IS NULL) AS salary_nulls
FROM employees;

SELECT
    SUM(shipment_id IS NULL) AS shipment_id_nulls,
    SUM(customer_id IS NULL) AS customer_id_nulls,
    SUM(partner_id IS NULL) AS partner_id_nulls,
    SUM(origin_branch_id IS NULL) AS origin_branch_nulls,
    SUM(destination_branch_id IS NULL) AS destination_branch_nulls,
    SUM(booking_date IS NULL) AS booking_date_nulls,
    SUM(service_type IS NULL) AS service_type_nulls,
    SUM(package_type IS NULL) AS package_type_nulls,
    SUM(weight_kg IS NULL) AS weight_nulls,
    SUM(distance_km IS NULL) AS distance_nulls,
    SUM(shipping_cost IS NULL) AS shipping_cost_nulls,
    SUM(shipment_status IS NULL) AS status_nulls,
    SUM(expected_delivery_date IS NULL) AS expected_date_nulls,
    SUM(actual_delivery_date IS NULL) AS actual_date_nulls
FROM shipments;


#Solving Questions:

#1--- Delivered shipments
SELECT *
FROM shipments
WHERE shipment_status = 'Delivered';

#2--- Shipping cost greater than ₹1,000
SELECT *
FROM shipments
WHERE shipping_cost > 1000;

#3--- Weight greater than 5 kg
SELECT *
FROM shipments
WHERE weight_kg > 5;

#4--- Express shipments
SELECT *
FROM shipments
WHERE service_type = 'Express';

#5---Delayed or Returned shipments
 SELECT *
FROM shipments
WHERE shipment_status IN ('Delayed', 'Returned');

#6---Customers from Chennai
SELECT *
FROM customers
WHERE city = 'Chennai';

#7---Delivery Agents
SELECT *
FROM employees
WHERE role = 'Delivery Agent';

#8---Shipments booked Jan–Mar 2025
SELECT *
FROM shipments
WHERE booking_date BETWEEN '2025-01-01' AND '2025-03-31';

#9---Number of shipments by status
SELECT
    shipment_status,
    COUNT(*) AS total_shipments
FROM shipments
GROUP BY shipment_status;

#10---Number of shipments by service type
SELECT
    service_type,
    COUNT(*) AS total_shipments
FROM shipments
GROUP BY service_type;

#11---Total revenue by service type
SELECT
    service_type,
    SUM(shipping_cost) AS total_revenue
FROM shipments
GROUP BY service_type;

#12---Average shipping cost by service type
SELECT
    service_type,
    AVG(shipping_cost) AS average_shipping_cost
FROM shipments
GROUP BY service_type;

#13---Customers by city
SELECT
    city,
    COUNT(*) AS total_customers
FROM customers
GROUP BY city;


#14---Employees by role
SELECT
    role,
    COUNT(*) AS total_employees
FROM employees
GROUP BY role;

#15---Total payment by payment method
SELECT
    payment_method,
    SUM(amount) AS total_payment
FROM payments
GROUP BY payment_method;

#16---Average rating by feedback category
SELECT
    feedback_category,
    AVG(rating) AS average_rating
FROM feedback
GROUP BY feedback_category;

#17---Total shipments
SELECT COUNT(*) AS total_shipments
FROM shipments;

#18---Total shipping revenue
SELECT SUM(shipping_cost) AS total_revenue
FROM shipments;

#19---Service types with more than 1,000 shipments
SELECT
    service_type,
    COUNT(*) AS total_shipments
FROM shipments
GROUP BY service_type
HAVING COUNT(*) > 1000;

#20---Cities with more than 300 customers
SELECT
    city,
    COUNT(*) AS total_customers
FROM customers
GROUP BY city
HAVING COUNT(*) > 300;

#21---Shipment + customer
SELECT
    s.shipment_id,
    c.customer_name,
    s.booking_date,
    s.shipping_cost
FROM shipments s
JOIN customers c
    ON s.customer_id = c.customer_id;

#22---Shipment + courier partner
SELECT
    s.shipment_id,
    cp.partner_name,
    s.service_type,
    s.shipping_cost
FROM shipments s
JOIN courier_partners cp
    ON s.partner_id = cp.partner_id;
    
#23---Shipments above average shipping cost
SELECT *
FROM shipments
WHERE shipping_cost > (
    SELECT AVG(shipping_cost)
    FROM shipments
);

#24---Customers with more shipments than average
SELECT
    customer_id,
    COUNT(*) AS total_shipments
FROM shipments
GROUP BY customer_id
HAVING COUNT(*) > (
    SELECT AVG(shipment_count)
    FROM (
        SELECT customer_id, COUNT(*) AS shipment_count
        FROM shipments
        GROUP BY customer_id
    ) x
);

#25---Customers with more than 5 shipments
WITH customer_shipments AS (
    SELECT
        customer_id,
        COUNT(*) AS total_shipments
    FROM shipments
    GROUP BY customer_id
)
SELECT *
FROM customer_shipments
WHERE total_shipments > 5;

#26---Courier partner with highest revenue
WITH courier_revenue AS (
    SELECT
        partner_id,
        SUM(shipping_cost) AS total_revenue
    FROM shipments
    GROUP BY partner_id
)
SELECT
    cr.partner_id,
    cp.partner_name,
    cr.total_revenue
FROM courier_revenue cr
JOIN courier_partners cp
    ON cr.partner_id = cp.partner_id
ORDER BY cr.total_revenue DESC
LIMIT 1;

#27--- Service types with average cost > ₹500
WITH service_cost AS (
    SELECT
        service_type,
        AVG(shipping_cost) AS average_cost
    FROM shipments
    GROUP BY service_type
)
SELECT *
FROM service_cost
WHERE average_cost > 500;

#28---ROW_NUMBER — shipments by cost
SELECT
    shipment_id,
    shipping_cost,
    ROW_NUMBER() OVER (
        ORDER BY shipping_cost DESC
    ) AS row_num
FROM shipments;

#29---Top 3 expensive shipments per service type
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

#30---Rank courier partners by rating
SELECT
    partner_id,
    partner_name,
    rating,
    RANK() OVER (
        ORDER BY rating DESC
    ) AS rating_rank
FROM courier_partners;

#30---Top 3 Shipments Per Service
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
SELECT
    shipment_id,
    service_type,
    shipping_cost
FROM ranked_shipments
WHERE rn <= 3
ORDER BY
    service_type,
    shipping_cost DESC;
    
#31---Courier Ranking
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

