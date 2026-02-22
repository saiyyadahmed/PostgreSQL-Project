-- Drop tables 
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS books;

-- Create Books Table 

CREATE TABLE Books(
    Book_ID SERIAL PRIMARY KEY,
    Title TEXT,
    Author VARCHAR(150),
    Genre VARCHAR(150),
    Published_Year INT,
    Price NUMERIC(10,2),
    Stock INT
);

-- Create Customers Table 

CREATE TABLE customers (
    Customer_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(150),
    Phone VARCHAR(150),
    City VARCHAR(150),
    Country VARCHAR(150)
);

-- Create Orders Table

CREATE TABLE orders(
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10,2)
);


-- Import Data into Books Table

COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock)
FROM 'D:/DATASETS/Books.csv'
CSV HEADER;

-- Import Data into customers Table

COPY customers(Customer_ID, Name, Email, Phone, City, Country)
FROM 'D:/DATASETS/customers.csv'
CSV HEADER;

-- Import Data into Orders Table

copy  orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount)
from 'D:/DATASETS/orders.csv'
csv header; 


select * from Books;
select * from customers;
select * from orders;


-- 1) Retrieve all books in the "Fiction" genre:

select * from Books
WHERE genre='Fiction';

-- 2) Retrieve all books in the "Biography" genre:

SELECT * FROM Books
WHERE genre='Biography';

-- 3) Retrieve all books in the "Science Fiction" genre:

SELECT * FROM books
WHERE genre='Science Fiction';


-- 4) Find books published after the year 1950:

SELECT * FROM Books
WHERE PUBLISHED_YEAR>1950;

-- 5) Find books published after the year 2015:

SELECT * FROM Books
WHERE published_year>2015;

-- 6) List all customers from the Iceland :

SELECT * FROM customers
WHERE country='Iceland';

-- 7) List all customers from the Lake Robert:

SELECT * FROM customers
WHERE city='Lake Robert';


-- 8) Show orders placed in November 2023:

SELECT * FROM orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

-- 9) Show orders placed in December 2023:

SELECT * FROM orders
WHERE order_date BETWEEN '2023-12-01' AND '2023-12-30';


-- 10) Retrieve the total stock of books available:

SELECT SUM(stock) AS Total_Stock
From Books;

-- 11) Find the details of the most expensive book:

SELECT * from Books
ORDER BY price DESC
LIMIT 1;

-- 12) Find the details of the most expensive book 5:

SELECT * FROM Books
ORDER BY price DESC
LIMIT 5;

-- 13) Show all customers who ordered more than 3 quantity of a book:

SELECT * FROM orders
WHERE quantity>3;

-- 14) Retrieve all orders where the total amount exceeds $20:

SELECT * FROM orders
WHERE total_amount>20;

-- 15) List all genres available in the Books table:

SELECT DISTINCT genre from Books;

select * from Books;
select * from customers;
select * from orders;
