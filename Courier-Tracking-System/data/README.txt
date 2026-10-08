COURIER TRACKING SYSTEM DATASET
=================================
10 tables x 5,000 rows = 50,000 rows.

Recommended SQL load order:
1. customers
2. courier_partners
3. branches
4. employees
5. shipments
6. shipment_items
7. tracking_events
8. delivery_attempts
9. payments
10. feedback

Main relationships:
shipments.customer_id -> customers.customer_id
shipments.partner_id -> courier_partners.partner_id
shipments.origin_branch_id -> branches.branch_id
shipments.destination_branch_id -> branches.branch_id
employees.branch_id -> branches.branch_id
shipment_items.shipment_id -> shipments.shipment_id
tracking_events.shipment_id -> shipments.shipment_id
tracking_events.branch_id -> branches.branch_id
tracking_events.employee_id -> employees.employee_id
delivery_attempts.shipment_id -> shipments.shipment_id
delivery_attempts.employee_id -> employees.employee_id
payments.shipment_id -> shipments.shipment_id
feedback.shipment_id -> shipments.shipment_id
feedback.customer_id -> customers.customer_id

All data is synthetic and intended for SQL, Power BI, Excel and data-analytics practice.
