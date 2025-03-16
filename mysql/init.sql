-- This is a database file. Here you create a table and add values
CREATE DATABASE IF NOT EXISTS mydatabase;
USE mydatabase;

-- users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);

-- Add values
INSERT INTO users (username, email) VALUES
('Pavel', 'pavel123@email.com'),
('Sveta', 'sveta321@email.com'),
('John', 'john228@email.com');

-- products table
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- Add values
INSERT INTO products (name, price) VALUES
('Phone', 19.40),
('Computer', 29.49),
('Notebook', 30.99);
