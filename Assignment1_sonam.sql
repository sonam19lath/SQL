-- SQL assignment 1
create database ecommerce;
use ecommerce;
-- "customers" table with columns: customer_id(primary key), customer_name, email,phone_number.
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    email varchar(50),
    phone_number varchar(15)
);

-- "orders" table with columns: order_id (primary key), customer_id (foreign key), order_date, total_amount

CREATE TABLE orders (
	order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- "products" table with columns: product_id (primary key), product_name, price.

CREATE TABLE products (
	product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10,2)
);

-- "order_items" table with columns: order_item_id (primary key), order_id (foreign key), product_id (foreign key), quantity.

CREATE TABLE order_items (
	order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id)  REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert at least 5 records into the "customers" table.

INSERT INTO customers (customer_id, customer_name, email, phone_number ) 
VALUES 
(111, 'John Doe', 'johndoe@gmail.com', '9876543210'),
(222, 'Jane Smith', 'janesmith@gmail.com', '1234567890'),
(333, 'Michael Johnson', 'michael@gmail.com', '45637298754'),
(444, 'Emily Brown', 'brown@gmail.com', '87373289373'),
(555, 'Peter Parker', 'parker@gmail.com', '7836829463');


-- Insert at least 10 records into the "products" table.

INSERT INTO products (product_id, product_name, price)
VALUES
(101,'Pencil',10),
(102,'Eraser',5),
(103,'Sharpner',5),
(104,'Box',100),
(105,'Chart paper',20),
(106,'copy',50),
(107,'bag',250),
(108,'colourbar',150),
(109,'glitter',80),
(110,'fevicol',30);

-- Insert at least 15 records into the "orders" table.

INSERT INTO orders (order_id, customer_id, order_date, total_amount) 
VALUES 
(1, 111, '2024-05-10', 150.00), -- 108, 1
(2, 222, '2024-05-11', 200.00), -- 109,105,104,111
(3, 111, '2024-05-12', 100.00), -- 105, 5
(4, 444, '2024-05-13', 300.00), -- 108 2
(5, 555, '2024-05-14', 350), -- 101,10 108 1
(6, 111, '2024-05-10', 150.00), -- 102 10,103 10 106 1
(7, 222, '2024-05-11',400.00), -- 107 1 109 1 105 3 101 1
(8, 111, '2024-05-12', 60.00), -- 110 2
(9, 444, '2024-05-13', 80.00), -- 109 1
(10, 333, '2024-05-14', 100.00), -- 104 1
(11, 111, '2024-05-10', 150.00),-- 108 1
(12, 222, '2024-05-11', 500.00), -- 107 2
(13, 111, '2024-05-12', 150.00), -- 108 1
(14, 555, '2024-05-13', 300.00), -- 108 2
(15, 333, '2024-05-14', 30.00), -- 110 1
(16, 333, '2024-05-15', 250.00); -- 107 1

-- Insert order item records into the "order_items"
INSERT INTO order_items (order_item_id, order_id, product_id, quantity)
VALUES
(1001,1, 108, 1),
(1002,2,109,1),
(1003,2,105,1),
(1004,2,104,1),
(1005,3,105,5), 
(1006,4, 108,2),
(1007,5,101,10),
(1008,5,108,1), 
(1009,6, 102,10),
(1010,6,103,10),
(1011,6,106,1),
(1012,7,107,1),
(1013,7,109,1),
(1014,7,105,3),
(1015,7,101,1), 
(1016,8,110,2), 
(1017,9,109,1), 
(1018,10,104,1), 
(1019,11,108,1),
(1020,12,107,2), 
(1021,13,108,1), 
(1022,14,108,2), 
(1023,15,110,1);

-- Retrieve all customers from the "customers" table.
select * from customers;

-- Retrieve the details of the orders made by a specific customer.
select * from orders where customer_id=111; 

-- Retrieve the total amount of each order along with the customer name.
select o.order_id, o.total_amount, c.customer_name from orders o
join customers c 
on c.customer_id=o.customer_id;

-- Retrieve the products that have a price greater than a specified amount.
select * from products where price>100;

-- Retrieve the total quantity sold for each product.
select product_id , sum(quantity) as Total_quantity_sold from order_items
group by 1 order by 1;

-- Retrieve the customer who made the highest total purchase amount.
select customer_id, sum(total_amount) as Total_purchase from orders
group by 1 order by 2 desc limit 1;

-- Retrieve the customers who have not placed any orders.

select customer_id from customers
where customer_id NOT IN(select customer_id from orders);

-- Retrieve the order with the highest total amount.

select * from orders
order by total_amount desc limit 1;

-- Retrieve the products that have been ordered the most.

select product_id, sum(quantity) as Total_quantity from order_items
group by 1 order by 2 desc limit 1;

-- Retrieve the customers who have placed orders for a specific product

select o.customer_id,ot.product_id from orders o
join order_items ot on o.order_id=ot.order_id
where ot.product_id=101;

-- Update the price of a specific product.
select * from products;
update products set price =3 where product_id=102;

-- Update the customer details for a specific customer.

select * from customers;
update customers set email='peter@gmail.com' where customer_id=555;

-- Delete a specific order from the "orders" table.

delete from order_items where order_id= 15;
delete from orders where order_id=15;

-- Perform an inner join between the "orders" and "customers" tables to retrieve the order details 
-- along with the customer name.

select o.*, c.customer_name from orders o
join customers c on o.customer_id=c.customer_id;

-- Perform a left join between the "customers" and "orders" tables to retrieve all customers, including
-- those who have not placed any orders.
INSERT INTO customers (customer_id, customer_name, email, phone_number ) 
VALUES 
(666, 'Alen bran', 'alen@gmail.com', '9674938303');
select * from customers c
left join orders o 
on c.customer_id = o.customer_id;

-- Add a unique constraint on the email column of the "customers" table.

alter table customers add constraint check(email like'%@%._%'); 
select * from customers;
INSERT INTO customers (customer_id, customer_name, email, phone_number ) 
VALUES 
(777, 'Alexander', 'gmail.com', '5647339374');
-- error code 3819 check constraints

-- Add a foreign key constraint on the customer_id column of the "orders" table, referencing the
-- customer_id column of the "customers" table

alter table orders add constraint foreign key (customer_id) references customers(customer_id);

-- 