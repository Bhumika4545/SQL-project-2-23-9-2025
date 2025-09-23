-- Create Database
CREATE DATABASE ecommerce;
USE ecommerce;

-- Customers Table
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address TEXT
);

-- Categories Table
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

-- Products Table
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Orders Table
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Order_Items Table (M:N relationship)
CREATE TABLE Order_Items (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Payments Table
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT UNIQUE,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    method ENUM('Credit Card', 'UPI', 'Cash', 'NetBanking'),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
-- =======================================
-- 1. Create Database and Use It
-- =======================================
CREATE DATABASE ecommerce;
USE ecommerce;

-- =======================================
-- 2. Customers Table
-- =======================================
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address TEXT
);

-- =======================================
-- 3. Categories Table
-- =======================================
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

-- =======================================
-- 4. Products Table
-- =======================================
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,   -- Demonstrates DEFAULT constraint
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- =======================================
-- 5. Orders Table
-- =======================================
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- =======================================
-- 6. Order_Items Table (M:N relationship)
-- =======================================
CREATE TABLE Order_Items (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- =======================================
-- 7. Payments Table
-- =======================================
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT UNIQUE,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    method ENUM('Credit Card', 'UPI', 'Cash', 'NetBanking'),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

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
VALUES (1, 1, 1), (2, 2, 2);

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

