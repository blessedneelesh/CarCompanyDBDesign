-- Submitted By: Neelesh Maharjan (C0838743)
-- 				 Atul Shrestha (C0845413)
-- 				 Nagaraju Tallapelly (C0859913)
-- 				 Pratima Bhattarai Acharya (C0846025)


-- 1.	Write a query that displays order id or order no., client_id , and client address.
select invoice_id, customer_id, address
from sales_invoice
	join customer
    using (customer_id);

 -- 2.	Write a query that display the product/service id or product number that have been NOT sold to any customer. 
select car_id, make, model 
from car
where car_id
	not in (select car_id from sales_invoice );

-- 3.	Write a query that display product/service information (productid, desc, cost, and another information of your
-- choice) and it is related inventory or store if there is any.
select car_id, make, model, car_for_sale, warehouse_name, location as warehouse_location 
from car
	join inventory
    using (car_id)
    join warehouse
    using (warehouse_id);

-- 4.	Write a query that display the list of customers/clients who made order and the list of the products/services in each order.
select customer_id, concat(first_name, ' ', last_name) as Customer_name, car_id, make, model, invoice_id order_num
from customer
	join sales_invoice
    using (customer_id)
    join car 
    using (car_id);
    
-- 5.	Write a query that display the list of customers/clients who never made order.
select customer_id, concat(first_name, ' ', last_name) as Customer_name
from customer
where customer_id 
	not in (select customer_id from sales_invoice);

-- 6.	Write a query that display the list of products/services that never sold.
select car_id, make, model, engine_cc
from car
where car_id
	not in (select car_id from sales_invoice);

-- 7.	Write a query that display the top customers/clients (received most amount of services)
select  customer_id, concat(first_name, ' ', last_name) as Customer_name, count(customer_id) as count
from customer
			join sales_invoice
            using (customer_id)
group by (customer_id)
having count(customer_id) = (
select max(count) from (
select count(customer_id) as count
from sales_invoice
group by (customer_id))  as T1);

-- 8.	Write a query that display the worst customers/clients (who received lowest service in total or no service at all )
select customer_id, concat(first_name, ' ', last_name) as Customer_name
from customer
where customer_id 
	not in (select customer_id from sales_invoice)
UNION
select  customer_id, concat(first_name, ' ', last_name) as Customer_name
from customer
			join sales_invoice
            using (customer_id)
group by (customer_id)
having count(customer_id) = (
select min(count) from (
select count(customer_id) as count
from sales_invoice
group by (customer_id))  as T1);

