use ecommerce;
-- ==================================================
-- INSERT SAMPLE DATA
-- ==================================================
INSERT INTO Customers (name, email, phone, address) 
VALUES 
('Riya Sharma', 'riya@email.com', '9876543210', 'Delhi'),
('Aman Verma', 'aman@email.com', NULL, 'Mumbai');

INSERT INTO Categories (category_name) VALUES ('Electronics'), ('Clothing');

INSERT INTO Products (name, price, stock, category_id) 
VALUES 
('Laptop', 55000.00, 10, 1),
('T-shirt', 500.00, 50, 2);

INSERT INTO Orders (customer_id, total) VALUES (1, 1000), (2, 2000);

INSERT INTO Order_Items (order_id, product_id, quantity) 
VALUES (  1, 1, 1), (2, 2, 2);

INSERT INTO Payments (order_id, amount, method) 
VALUES (1, 1000, 'UPI'), (2, 2000, 'Cash');

-- ==================================================
-- NOW ANSWER THE 10 QUESTIONS WITH QUERIES
-- ==================================================

-- 1. Difference between NULL and 0 (Example Check)
SELECT name, phone FROM Customers WHERE phone IS NULL;  -- NULL check
SELECT * FROM Products WHERE stock = 0;                 -- stock is 0

-- 2. Default Constraint Example
INSERT INTO Products (name, price, category_id) 
VALUES ('Headphones', 1500.00, 1);  -- stock will default to 0

-- 3. IS NULL Example
SELECT * FROM Customers WHERE phone IS NULL;

-- 4. Update Multiple Rows Example
UPDATE Products SET price = price * 1.10 WHERE category_id = 2;

-- 5. Insert Partial Values Example
INSERT INTO Customers (name, email) VALUES ('Neha Gupta', 'neha@email.com');

-- 6. NOT NULL Violation Example (This will give ERROR if executed)
-- INSERT INTO Customers (name, email) VALUES (NULL, 'test@email.com');

-- 7. Rollback Deletion Example
START TRANSACTION;
DELETE FROM Customers WHERE customer_id = 2;
ROLLBACK; -- restores deleted record

-- 8. Insert into Specific Columns Only
INSERT INTO Customers (name, email) VALUES ('Rohan Das', 'rohan@email.com');

-- 9. Insert Using SELECT
INSERT INTO Orders (customer_id, total)
SELECT customer_id, 500 FROM Customers WHERE name = 'Neha Gupta';

-- 10. ON DELETE CASCADE Example
-- (Redefining Orders with ON DELETE CASCADE for demo)
DROP TABLE Orders;
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE
);

-- Now, deleting a customer will also delete their orders automatically.

