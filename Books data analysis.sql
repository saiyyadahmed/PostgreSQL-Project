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

-- 16) Find the book with the lowest stock:

SELECT * FROM Books
ORDER BY stock
LIMIT 5;

-- 17) Calculate the total revenue generated from all orders:

SELECT SUM(total_amount) As Revenue 
FROM Orders;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:

SELECT b.Genre, SUM(o.Quantity) AS Total_Books_sold
FROM Orders o
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.Genre;

-- 2) Find the average price of books in the "Biography" genre:

SELECT AVG(price) AS average_price
FROM Books
WHERE genre='Biography';

-- 3) List customers who have placed at least 2 orders:

SELECT o.customer_id, c.name, COUNT(o.Order_id) AS ORDER_COUNT
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(Order_id) >=2;

-- 4) Find the most frequently ordered book:

SELECT o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY ORDER_COUNT DESC LIMIT 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :

SELECT * FROM books
WHERE genre ='Fantasy'
ORDER BY price DESC LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author:

SELECT b.author, SUM(o.quantity) AS Total_Books_Sold
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY b.Author;

-- 7) List the cities where customers who spent over $30 are located:

SELECT DISTINCT c.city, total_amount
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
WHERE o.total_amount > 30;

-- 8) Find the customer who spent the most on orders:

SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_spent Desc LIMIT 1;

--9) Calculate the stock remaining after fulfilling all orders:

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id;


select * from Books;
select * from customers;
select * from orders;
