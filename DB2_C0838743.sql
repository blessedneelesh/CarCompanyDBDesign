-- Name: Neelesh Maharjan
-- Student Id: C0838743
-- Project Name: NNAP Car Dealers
-- Term: CSAT Summer 2022
-- Professor: Alireza Moghaddam
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------- Build - CREATE Statements ---------------------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CAR
create table car (
car_id decimal(4,0) not null primary key,
make varchar(30) not null,
model varchar(20) not null,
color varchar(20) not null,
height decimal (5,0) not null
);

-- CUSTOMER
create table customer(
customer_id int not null primary key auto_increment,
first_name varchar(30) not null,
last_name varchar(30) not null,
phone_number decimal(10,0) not null,
address varchar(25) not null,
zip varchar(6) not null
);



-- DEPARTMENT
create table department (
department_id decimal(2,0) not null primary key,
 department_name varchar(50) not null
);



-- EMPLOYEE
create table employee(
employee_id decimal(3,0) not null primary key,
first_name varchar(20) not null,
middle_initial varchar(1),
last_name varchar(20) not null,
birth_date date,
soc_sec_no decimal(9,0) not null,
hire_date date,
work_dept_id numeric (2,0),
job_id numeric(2,0),
salary numeric(6,0),
bonus numeric(7,2),
commission numeric(7,2)
);


-- INVENTORY
create table inventory(
car_id decimal(4,0) not null,
warehouse_id decimal(4,0) not null,
availability varchar(1) not null default 'Y'
);


-- JOB
create table job (
	job_id decimal(2,0) not null,
    job_title character(20) not null,
    min_salary numeric(5,0) not null,
    max_salary numeric(6,0) not null
);


-- MECHANIC_SKILL
create table mechanic_skill(
mechanic_id decimal(4,0) not null,
skill_id decimal(3,0) not null,
experience decimal(2,0)
);


-- PART
create table part(
car_id decimal(4,0) not null,
vendor_id decimal(4,0) not null,
part_description text,
part_cost decimal(4,0) not null
);






-- SALES_INVOICE
create table sales_invoice (
invoice_id int not null primary key auto_increment,
date date not null default (curdate()),
price decimal(8,0) not null,
on_road_price decimal (8,0) not null,
car_id decimal(4,0) not null,
customer_id int not null,
salesperson_id decimal(3,0) not null
);


-- SERVICE_MECHANIC_DETAIL
create table service_mechanic_detail (
service_ticket_id decimal(4,0) not null,
mechanic_id decimal(3,0) not null,
hours decimal(2,0),
comment text,
rate_per_hour decimal(3,0)
);





-- SERVICE_TICKET
create table service_ticket(
service_ticket_id decimal(4,0) not null primary key,
car_id decimal(4,0) not null,
customer_id int not null,
date_received date not null default (curdate()),
issues text,
date_returned date 
);



-- SKILL
create table skill(
skill_id decimal(3,0) not null primary key,
skill varchar(30) not null
);


-- VENDOR
create table vendor (
vendor_id decimal(4,0) not null primary key,
company_name varchar(30) not null,
contact_person varchar(30)
);


-- WAREHOUSE
create table warehouse (
warehouse_id decimal(4,0) not null primary key,
warehouse_name varchar (30) not null,
location varchar(20)
);


-- ZIP
create table zip(
zip varchar(6) not null primary key,
province varchar(20) not null,
city varchar(20) not null
);




-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------- Build - Constraints - ALT ---------------------------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- CAR -------------------------------------------------------------------------------------------------------------
describe car;
select * from car;
-- show all the constraints in a table
show create table employee;

alter table car 
add column car_for_sale varchar(1) not null default 'N';

alter table car
add constraint car_car_for_sale_ck
check (car_for_sale in ('N','Y'));

alter table car
add car_length decimal(5,0) not null;

alter table car
add width decimal(5,0) not null;

alter table car
add engine_cc decimal(5,0) not null;




-- CUSTOMER---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
describe customer;
select * from customer;


show create table customer;

alter table customer
add constraint customer_zip_fk
foreign key (zip)
references zip(zip);


alter table customer
add constraint customer_phone_number
unique(phone_number);

alter table customer  auto_increment=0;



-- DEPARTMENT -------------------------------------------------------------------------------------------------------------------------------------------------------------
show create table job;
select * from department;

-- JOB -------------------------------------------------------------------------------------------------------------------------------------------------------------
alter table job 
add constraint job_pk
primary key (job_id) ;

-- EMPLOYEE --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- describe employee
describe employee;
-- show all the constraints in a table
show create table employee;
-- select query
select * from employee;

alter table employee
add constraint employee_soc_sec_no_uk
unique (soc_sec_no);

alter table employee
add constraint employee_work_dept_id_fk
foreign key (work_dept_id)
references department(department_id);

 -- THIS QUERY WAS REMOVED
alter table employee             
add constraint employee_job_id_fk
foreign key (job_id)
references job(job_id);

alter table employee 
add constraint employee_hire_date_ck
check(hire_date > birth_date);

alter table employee
add constraint employee_salary_1
check (salary between 60000 and 92000 and salary>bonus and salary > commission);

alter table employee
add constraint employee_bonus_commission_ck
check (((bonus is not null) and (commission is not null)) or ((bonus is null ) and (commission is null)));

alter table employee
modify hire_date date not null default (curdate());


-- INVENTORY -------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from inventory;
describe inventory;

alter table inventory
add constraint inventory_pk 
primary key (car_id, warehouse_id);

-- THESE TWO STATEMENTS WERE REMOVED
alter table inventory
add constraint inventory_car_id_fk
foreign key (car_id)
references car(car_id);

alter table inventory
add constraint inventory_warehouse_id_fk
foreign key (warehouse_id)
references warehouse(warehouse_id);

alter table inventory
add constraint inventory_availability_ck
check (availability in ('Y','N'));


alter table job
drop column min_salary;

alter table job
drop column max_salary;


-- PART -------------------------------------------------------------------------------------------------------------------------------------------------------------
alter table part
add constraint part_pk
primary key (car_id, vendor_id);


alter table part
add constraint part_car_id_fk
foreign key (car_id)
references car(car_id);

alter table part
add constraint part_vendor_id_fk
foreign key (vendor_id)
references vendor(vendor_id);



-- SALES_INVOICE -------------------------------------------------------------------------------------------------------------------------------------------------------------
alter table sales_invoice
add constraint sales_invoice_on_road_price
check (on_road_price > price );

alter table sales_invoice
add constraint sales_invoice_car_id_fk
foreign key(car_id)
references car(car_id);

alter table sales_invoice
add constraint sales_invoice_customer_id_fk
foreign key(customer_id)
references customer(customer_id);

alter table sales_invoice 
drop constraint sales_invoice_customer_id_fk;

alter table sales_invoice
add vin_number varchar(17) not null unique;

alter table sales_invoice
modify customer_id int not null;

alter table sales_invoice
add constraint sales_invoice_salesperson_id_fk
foreign key(salesperson_id)
references employee(employee_id);


-- SERVICE_MECHANIC_DETAIL -------------------------------------------------------------------------------------------------------------------------------------------------------------

-- FOLLOWING WAS REMOVED
describe service_mechanic_detail;
select * from service_mechanic_detail;

alter table service_mechanic_detail
add constraint service_mechanic_detail_pk 
primary key (service_ticket_id, mechanic_id);

alter table service_mechanic_detail
add constraint service_mechanic_detail_service_ticket_id_fk
foreign key (service_ticket_id)
references service_ticket(service_ticket_id);

alter table service_mechanic_detail
add constraint service_mechanic_detail_mechanic_id_fk
foreign key (mechanic_id)
references employee(employee_id);



-- SERVICE_TICKET -------------------------------------------------------------------------------------------------------------------------------------------------------------


-- FOLLOWING WAS REMOVED
describe service_ticket;
select * from service_ticket;

show create table service_ticket;



alter table service_ticket
add constraint service_ticket_car_id_fk
foreign key (car_id)
references car(car_id);

alter table service_ticket
add constraint service_ticket_customer_id_fk
foreign key (customer_id)
references customer(customer_id);


alter table service_ticket
modify customer_id int not null;

-- ZIP -------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from zip;







-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------- Build - Insert Statements ---------------------------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



-- CAR-------------------------------------------------------------------------------------------
insert into car(car_id,make,model,color,height, car_length, width, engine_cc, car_for_sale)
values(2050,'Mercedes-Benz','A-Class', 'Monza Red',305, 4382,1854,2759,'N'),
(2052,'Audi','A3', 'race red', 1394, 4783, 1949,4951, 'N'),
(2053,'Audi','A4', 'phytonic blue', 1415, 4783, 1949,3798, 'Y'),
(2054,'Audi','A4 allroad', 'cosmic blue', 1394, 4830, 1949,4951, 'N'),
(2055,'Audi','A5', 'jupiter red', 1415, 4830, 1949,3798, 'N'),
(2056,'Audi','A6', 'cosmic blue', 1675, 4783, 1949,6162, 'N'),
(2057,'Audi','A6 allroad', 'jupiter red', 1415, 3946, 1949,3342, 'Y'),
(2058,'Audi','A7', 'race red', 1394, 4830, 1949,4951, 'N'),
(2059,'Audi','A8', 'jupiter red', 1675, 3946, 1949,6162, 'N'),
(2060,'GMC','Acadia', 'black', 1400, 4783, 1949,4951, 'Y');

insert into car(car_id,make,model,color,height, car_length, width, engine_cc, car_for_sale)
values(2061,'Hyundai','Accent', 'race red', 1490, 4708, 1940,4951, 'N'),
(2062,'Honda','Accord', 'phytonic blue', 1415, 4783, 1949,3798, 'Y'),
(2063,'Honda','Accord Hybrid', 'cosmic blue', 1490, 4708, 1949,4951, 'N'),
(2064,'Lucid','Air', 'jupiter red', 1415, 4830, 1949,3798, 'N'),
(2065,'Nissan','Altima', 'cosmic blue', 1490, 5189, 1949,6162, 'N'),
(2066,'Nissan','Ariya', 'jupiter red', 1415, 5189, 1940,3342, 'Y'),
(2067,'Nissan','Armada', 'race red', 1394, 4830, 1949,4951, 'N'),
(2068,'Volkswagen','Atlas', 'jupiter red', 1490, 3946, 1949,6162, 'N'),
(2069,'Volkswagen','Atlas Cross sport', 'black', 1400, 4783, 1940,4951, 'Y');

insert into car(car_id,make,model,color,height, car_length, width, engine_cc, car_for_sale)
values(2070,'Toyota','Avalon', 'quartzite grey', 4830, 4708, 2081,6410, 'N'),
(2071,'Toyota','Avalon Hybrid', 'race red', 1490, 4708, 1940,4951, 'N'),
(2072,'Lamborghini','Aventador', 'quartzite grey', 1515, 4783, 2081,6410, 'Y'),
(2073,'Lincoln','Aviator', 'quartzite grey', 1490, 4708, 1949,4951, 'N'),
(2074,'Bentley','Bentayga', 'black raven', 1415, 4830, 2081,3982, 'N'),
(2075,'Chevrolet','Blazer', 'black raven', 1730, 5189, 1949,6162, 'N'),
(2076,'Chevrolet','Bolt EV', 'jupiter red', 1415, 5189, 1940,3342, 'Y'),
(2077,'Chevrolet','Bolt EUV', 'blue racing', 1394, 4830, 1949,3982, 'N'),
(2078,'Chevrolet','Blazer EV', 'jupiter red', 1490, 4830, 2081,6162, 'N'),
(2079,'Toyota','bZ4X', 'black', 1515, 4783, 1940,4951, 'Y'),
(2080,'Toyota','C-HR', 'blue racing', 1515, 4640, 1940,4951, 'N');

-- ZIP -----------------------------------------------------------------------------------------------------------------------------------------------------
insert into zip values('H1H1JU', 'quebec', 'montreal'),
('B3HR6H', 'novascotia', 'halifax'),
('M3J5Y7', 'ontario', 'toronto'),
('N8H7UI', 'new brunswick', 'moncton'),
('S4GH5J', 'manitoba', 'steinbach'),
('C5HJ6J', 'prince edward island', 'charlottetown'),
('R8K9U9', 'saskatchewan', 'regina'),
('V0C4K4', 'british columbia', 'british columbia'),
('A5G1J7', 'alberta', 'calgary'),
('L7H3F3', 'newfoundland', 'st. johns'),
('M1O6S9', 'ontario', 'mississauga'),
('V1JM46', 'british columbia', 'british columbia'),
('M8R0K5', 'ontario', 'scarborough'),
('M3J9G9', 'ontario', 'toronto'),
('B3H7J7', 'novascotia', 'shelburne');

insert into zip (zip, province, city)
values('M1K4M6', 'Ontario', 'Scarborough');


-- CUSTOMER --------------------------------------------------------------------------------------------------------------------------------------------
insert into customer(first_name, last_name, phone_number, address,zip)
values ('den', 'miller', 5541256, '55 clara avenue', 'B3HR6H'),
('garnett', 'vargas', 22523233, '12 radnor avenue', 'M1K4M6'),
('reuben', 'mares', 12523223, ' 5 st.clair avenue', 'M1K4M6'),
('gabe', 'vargas', 82523233, '11 linden avenue', 'B3HR6H'),
('karan', 'khanna', 8252223, '14 magnolia avenue', 'S4GH5J'),
('francis', 'ajenstat', 622382323, '17 malley rd', 'M8R0K5'),
('sariya', 'red', 6252323, '15 lebovic avenue', 'V1JM46'),
('kirk', 'john', 625232332, '14 sunridge dr', 'M3J5Y7'),
('kim', 'ralls', 52523234, '29 valdane dr', 'M3J5Y7'),
('michael', 'scott', 825233234, '49 adair rd', 'B3H7J7'),
('reed', 'koch', 22523232, '29 holmstead ave', 'V1JM46'),
('Francis', 'Nganoou', 62522323, '13 donora dr', 'M1O6S9'),
('Max', 'Holloway', 625232331, '16 wayland ave', 'L7H3F3'),
('Khabib', 'Nurmagomedov', 475232323, '17 pine crescent', 'A5G1J7'),
('tony', 'furguson', 7252323, '69 mcguill rd', 'M1K4M6'),
('islam', 'makhachev', 72532323, '49 thorton ave', 'V0C4K4'),
('Daniel', 'Cormier', 82523323, '29 thorton ave', 'C5HJ6J'),
('yi', 'welie', 825232232, '18 summit dr', 'R8K9U9'),
('joanna', 'jerdzyck', 525232323, '11 summit dr', 'R8K9U9');


-- DEPARTMENT ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
insert into department(department_id,department_name)
values(1,'Sales department');
insert into department(department_id,department_name)
values(2,'Management and Administration Department'),
(3,'The Service Department'),
(4,'Parts Department');

-- JOB ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
insert into job values 
(1, 'Sales Person'),
(2, 'Customer Service'),
(3, 'Mechanic'),
(4, 'Parts Technicians'),
(5, 'Security');

insert into job values
(6, 'Car Detailer'),
(7, 'Lot Manager');  



-- EMPLOYEE ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
insert into employee (employee_id, first_name, middle_initial, last_name, birth_date,
soc_sec_no, hire_date, work_dept_id, job_id, salary, bonus, commission) 
values (998, 'Neelesh', null,'Mrz', '1999-08-23', 965458573, '2022-06-08', 1,3,70000,550,55);

insert into employee (employee_id, first_name, middle_initial, last_name, birth_date,
soc_sec_no, hire_date, work_dept_id, job_id, salary, bonus, commission) 
values (200, 'manish', null,'lama', '1999-08-23', 96568573, '2021-06-08', 2,6,85000,550,55),
(201, 'navaraj', null,'pokhrel', '1999-07-2', 96598573, '2021-01-28', 3,3,90000,550,55),
(202, 'amit', null,'shrestha', '1995-01-23', 969658573, '2021-02-18', 4,3,90000,null,null),
(203, 'ritesh', null,'silwal', '1994-08-3', 963058573, '2017-07-29', 4,3,70000,550,55),
(204, 'bishal', null,'malla', '1993-07-20', 9658523, '2013-06-15', 3,4,90000,550,55),
(205, 'manish', null,'thapa', '1990-02-25', 961058573, '2010-06-08', 2,4,90000,550,55),
(206, 'anmol', null,'maharjan', '1994-03-21', 965858573, '2015-08-16', 3,3,70000,null,null),
(207, 'sagar', null,'maharjan', '1997-04-22', 965968573, '2015-04-09', 2,4,80000,550,55),
(208, 'rishma', null,'maharjan', '1989-07-27', 965454273, '2013-08-08', 4,5,65000,550,55),
(209, 'prajina', null,'maharjan', '1987-05-03', 965498573, '2012-06-08',4 ,3,62000,550,55);

select * from employee;
insert into employee (employee_id, first_name, middle_initial, last_name, birth_date,
soc_sec_no, hire_date, work_dept_id, job_id, salary, bonus, commission) 
values(210, 'abdul', null,'khan', '1991-08-23', 960404373, '2013-06-27',1 ,2,62000,550,55),
(211, 'jose', null,'dangol', '1992-03-03', 965030573, '2014-06-28',2 ,2,62000,550,55),
(212, 'roshid', null,'shetty', '1993-02-21', 965040573, '2015-06-22',3 ,2,62000,550,55),
(213, 'sajith', null,'maharjan', '1994-01-22', 965018573, '2016-06-08',3 ,2,62000,550,55),
(214, 'arturo', null,'gatti', '1995-01-24', 963698073, '2016-06-08',1 ,2,62000,550,55),
(215, 'floyd', null,'mayweather', '1996-02-28', 960294173, '2014-06-08',2 ,2,62000,550,55),
(216, 'manny', null,'pacquio', '1997-03-26', 965496003, '2015-08-08',4 ,2,62000,550,55),
(217, 'canelo', null,'alvarez', '1998-04-24', 960063573, '2014-07-07',2 ,2,62000,5500,550),
(218, 'arturo', null,'donald', '1998-05-13', 101198573, '2022-05-06',1 ,2,62000,550,55),
(219, 'diana', null,'maharjan', '1989-06-03', 960048573, '2022-05-04',3 ,2,62000,550,55),
(220, 'luka', null,'brom', '1989-07-12', 965600573, '2021-06-09',3 ,2,62000,550,55),
(221, 'max', null,'holloway', '1994-08-20', 964400573, '2021-04-21',3 ,2,62000,550,55);

-- WAREHOUSE --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
insert into warehouse values
(1950, 'one medal automotive', 'Toronto'),
(1951, 'john turn cars', 'vancouver'),
(1952, 'duke empire', 'ottawa'),
(1953, 'xperts deals', 'calgary'),
(1954, 'auto ty', 'calgary'),
(1955, 'xperts deals', 'montreal'),
(1956, 'kkk auto', 'halifax'),
(1957, 'car newx', 'quebec'),
(1958, 'dashy cars', 'winnipeg'),
(1959, 'supersuper wheels', 'victoria'),
(1960, 'street rockerzzz', 'st.johns'),
(1961, 'jmd motors', 'regina'),
(1962, 'carvanna motors', 'hamilton'),
(1963, 'cargets auto', 'kelowna'),
(1964, 'bricks auto', 'charlottetown'),
(1965, 'modelsincarzz', 'peterborough'),
(1966, 'bygcarz motors', 'thunderbay'),
(1967, 'wheelsoncar auto', 'surrey'),
(1968, 'AUH motors', 'fredericton'),
(1969, 'tim auto', 'calgary'),
(1970, 'Sam deals', 'calgary');

-- INVENTORY -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
insert into inventory (car_id,warehouse_id,availability)
values(2050,1950,'Y'),
(2052,1950,'Y'),
(2052,1952,'N'),
(2053,1953,'Y'),
(2054,1953,'Y'),
(2055,1953,'Y'),
(2056,1955,'Y'),
(2056,1959,'N'),
(2056,1970,'Y');




-- MECHANIC_SKILL ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
insert into mechanic_skill(mechanic_id,skill_id, experience)
values (201,102,3),
(201,101,1),
(201,103,2),
(201,104,1),
(201,105,3),
(201,106,1),
(201,107,3),
(204,5,1),
(206,5,1),
(206,1,2),
(206,2,1),
(206,4,1);



-- VENDOR ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 insert into vendor values
(2001, 'Robert Bosch', 'Harry Maguire'),
(2002, 'Denso Corp', 'Arturo Anhalt'),
(2003, 'Magna International','Esteban M'),
(2004, 'Starlight Automall', 'Arturo Anhalt'),
(2005, 'AutoNation Inc', 'Arturo Anhalt'),
(2006, 'TruBlue Auto', 'Arturo Anhalt'),
(2007, 'Wheeler Dealer Enterprise', 'Arturo Anhalt'),
(2008, 'Caropedia', 'Arturo Anhalt'),
(2009, 'Motor Getawayz', 'Arturo Anhalt'),
(2010, 'Super Wheels', 'Arturo Anhalt');



-- PART-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
insert into part (car_id, vendor_id, part_description,part_cost)
values(2050,2010, 'alternators', 405),
(2053,2010, 'alternators', 405),
(2052,2010, 'alternators', 200),
(2053,2005, 'alternators', 450),
(2054,2005, 'starter', 60),
(2055,2005, 'starter', 120),
(2056,2005, 'Engine Position sensors', 1000),
(2057,2009, 'Ignition component', 5000),
(2058,2009, 'alternators', 150);

insert into part values (2052,2001, 'starter', 500);

-- SALES_INVOICE---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
insert into sales_invoice(invoice_id, date, price, on_road_price, car_id,customer_id,salesperson_id,vin_number)
values(default, default, 90500, 100000, 2050, 1, 210,'12HJ5541256554K25'),
(default, '2022-07-05', 90700, 1000000, 2050, 1, 210,'12HJ5541256544125'),
(default, '2022-06-15', 90700, 100000, 2050, 1, 214,'12HJ5541256574125'),
(default, default, 45000, 60000, 2052, 2, 214,'12HJ7541256554175'),
(default, default, 60000, 100000, 2052, 2, 214,'12HJ5541256554145'),
(default, default, 90500, 100000, 2052, 4, 218,'12HJ5541256554425'),
(default, default, 90000, 150000, 2052, 4, 218,'12HJ5541256594125'),
(default, default, 80500, 100000, 2053, 5, 218,'12HJ5541256553125'),
(default, default, 100500, 190000, 2054, 6, 214,'12HJ5541256554025'),
(default, default, 90500, 100000, 2055, 7, 210,'12HJ5541256554105'),
(default, default, 90500, 100000, 2055, 8, 214,'12HJ5541256054125'),
(default, default, 90500, 100000, 2050, 9, 218,'12HJ5541256551125'),
(default, default, 90500, 100000, 2057, 10, 210,'12HJ5541256554725'),
(default, default, 90500, 100000, 2056, 10, 214,'12HJ55412J6554125');


-- SERVICE_TICKET --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
insert into service_ticket (service_ticket_id, car_id, customer_id, date_received, issues, date_returned)
values (1, 2050, 1, default, 'something problem on brake and wiper', '2022-07-08'),
(2, 2050, 1, default, 'problem in ignition', null),
(3, 2052, 2, default, 'something starter', '2022-07-09'),
(4, 2052, 3, default, 'something brake', null),
(5, 2053, 4, default, 'need servicing', '2022-07-10'),
(6, 2054, 5, default, 'full servicing', '2022-07-12'),
(7, 2055, 6, default, 'car wash premium', null),
(10, 2056, 2, default, 'fuel leakage', '2022-07-15'),
(11, 2070, 3, default, 'complete repair', null),
(12, 2071, 10, default, 'something problem on brake and wiper', null);



select * from employee;
select * from job;
-- SERVICE_MECHANIC_DETAIL--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
insert into service_mechanic_detail (service_ticket_id, mechanic_id, hours, comment, rate_per_hour)
values (1,201,4,'problem leakage solved', 15),
(1,203,2,'problem sth solved', 15),
(1,202,1,'problem sth solved', 18),
(2,209,1,'problem brake solved', 15),
(3,209,4,'full wash solved', 15),
(4,206,3,'problem  solved', 20),
(4,201,6,'problem solved', 15),
(5,201,1,'problem solved', 15),
(6,202,2,'problem solved', 17),
(12,201,4,'leakage solved', 15),
(10,201,3,'solved', 20),
(7,203,2,'problem leakage solved', 15);





-- SKILL----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
insert into skill values
 (101,'Oil filter change'), 
 (102,'Wiper blades replacement'),
 (103,'Air filter replacement'),
 (104,'Scheduled maintenance'), 
 (105,'New Tires'), 
 (106,'Battery Replacement'), 
 (107,'Brake work'), 
 (108,'Antifreeze added'),
 (109,'Engine Tune up'),
 (110,'Wheels balanced');
 
 











-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------- SEQUENCE and IDENTITY ---------------------------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




-- This has been implemented in SALES_INVOICE and CUSTOMER tables. In the following way we implemented sequence and identity in our CSD2206 Term Project 1:
-- SALES_INVOICE: "invoice_id int not null primary key auto_increment"
-- CUSTOMER: "customer_id int not null primary key auto_increment"


 
 
 
 
 
 
 
 
 
 
 -- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------- Constraint Testing ---------------------------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
     
     


-- Constraint Test 1
-- Purpose: Confirm primary key constraint on employee table
-- valid test
-- Expected results: Insert add new row to employee table
-- Action:
		insert into employee (employee_id, first_name, middle_initial, last_name, birth_date,
		soc_sec_no, hire_date, work_dept_id, job_id, salary, bonus, commission) 
		values (555, 'adele', null,'m', '1999-08-23', 9654273, '2022-06-08', 1,3,70000,550,55);
-- test results: 1 row inserted 

-- Invalid test
-- Expected_results: Insert fails with SQL0803 duplicate key error.
-- Action:
		insert into employee (employee_id, first_name, middle_initial, last_name, birth_date,
		soc_sec_no, hire_date, work_dept_id, job_id, salary, bonus, commission) 
		values (998, 'Atul', null,'m', '1990-08-23', 9658573, '2012-06-08', 1,3,70000,550,55);
-- test results: Error Code: 1062. Duplicate entry '988' for key 'employee.PRIMARY'

-- Constraint Test 2
-- Purpose: Confirm primary key constraint on job table
-- valid test
-- Expected results: Insert add new row to job table
-- Action:
		insert into job (job_id, job_title) 
		values (19, 'Parts Technicians');
-- test results: 1 row inserted 

-- Invalid test
-- Expected_results: Insert fails with SQL0803 duplicate key error.
-- Action:
		insert into job (job_id, job_title) 
		values (4, 'Car Detailer');
-- test results: Error Code: 1062. Duplicate entry '4' for key 'job.PRIMARY'


-- Constraint Test 3	
-- Purpose: Confirm unique key constraint on soc_sec_no in employee table
-- valid test:
-- Expected results: Insert add new row to employee table
-- Action:
		insert into employee (employee_id, first_name, middle_initial, last_name, birth_date,
		soc_sec_no, hire_date, work_dept_id, job_id, salary, bonus, commission) 
		values (100, 'Bipish', null,'shrestha', '1999-08-23', 11111111, default, 1,3,70000,550,55);
-- test result: 1 row inserted

-- Invalid test
-- Expected_results: Insert fails with SQL0803 duplicate key error.
-- Action:
		insert into employee (employee_id, first_name, middle_initial, last_name, birth_date,
		soc_sec_no, hire_date, work_dept_id, job_id, salary, bonus, commission) 
		values (101, 'kabish', null,'shrestha', '1999-08-23', 11111111, default, 1,3,70000,550,55);
-- test results: Error Code: 1062. Duplicate entry '11111111' for key 'employee.employee_soc_sec_no_uk'

-- Constraint Test 4
-- Purpose: Confirm hire date is current date if hire date is unknown
-- valid test:
-- Expected results: Insert add new row to employee table with current date as hire date
-- Action:
		insert into employee (employee_id, first_name, middle_initial, last_name, birth_date,
		soc_sec_no, hire_date, work_dept_id, job_id, salary, bonus, commission) 
		values (103, 'Sajith', null,'Joshi', '1988-02-23', 927451573, default, 1,3,70000,55,55);
-- test result: 1 row(s) affected 

-- Constraint test 5
-- Purpose: Confirm hire date is greater than birth date.
-- invalid test:
-- Expected results: Error
		insert into employee (employee_id, first_name, middle_initial, last_name, birth_date,
		soc_sec_no, hire_date, work_dept_id, job_id, salary, bonus, commission) 
		values (104, 'kabina', null,'joshi', '1999-08-23', 965451573, '1998-08-23', 1,3,70000,550,55);
-- test result:Error Code: 3819. Check constraint 'employee_hire_date_ck' is violated.

-- Constraint test 6
-- Purpose: Confirm salary is between 30,000 and 500,000.
-- invalid test: test for lower range
-- Expected results: Error
		insert into employee (employee_id, first_name, middle_initial, last_name, birth_date,
		soc_sec_no, hire_date, work_dept_id, job_id, salary, bonus, commission) 
		values (105, 'luka', null,'modric', '2005-08-23', 865451573, '2022-08-23', 1,3,2000,550,55);
-- test result:Error Code: 3819. Check constraint 'employee_salary_1' is violated.

-- invalid test: test for higher range
-- Expected results: Error
		insert into employee (employee_id, first_name, middle_initial, last_name, birth_date,
		soc_sec_no, hire_date, work_dept_id, job_id, salary, bonus, commission) 
		values (105, 'luka', null,'modric', '2005-08-23', 765451573, '2022-08-23', 1,3,700000,550,55);
-- test result:Error Code: 3819. Check constraint 'employee_salary_1' is violated.

-- valid test: 
-- Expected results: insert add new row to employee table when salary is between 30000 and 100000
		insert into employee (employee_id, first_name, middle_initial, last_name, birth_date,
		soc_sec_no, hire_date, work_dept_id, job_id, salary, bonus, commission) 
		values (105, 'luka', null,'modric', '2005-08-23', 565451573, '2022-08-23', 1,3,70000,550,55);
-- test result: 1 row(s) affected

-- Constraint test 7
-- Purpose: Confirm salary must be greater than commission and bonus
-- invalid test:
		insert into employee (employee_id, first_name, middle_initial, last_name, birth_date,
		soc_sec_no, hire_date, work_dept_id, job_id, salary, bonus, commission) 
		values (106, 'james', null,'rodriguez', '2005-08-23', 565851573, '2022-08-23', 1,3,40000,50000,55);
-- test results: Error Code: 3819. Check constraint 'salary_ck' is violated.

-- valid test:
		insert into employee (employee_id, first_name, middle_initial, last_name, birth_date,
		soc_sec_no, hire_date, work_dept_id, job_id, salary, bonus, commission) 
		values (106, 'james', null,'rodriguez', '2005-08-23', 565851573, '2022-08-23', 1,3,60000,50000,55);
-- test results: 1 row(s) affected

-- Constraint test 8
-- Purpose: Confirm either bonus and commission should be null or not null.
-- invalid test:
		insert into employee (employee_id, first_name, middle_initial, last_name, birth_date,
		soc_sec_no, hire_date, work_dept_id, job_id, salary, bonus, commission) 
		values (107, 'robert', null,'lewandoski', '1985-08-23', 565871573, '2012-08-23', 1,3,60000,null,55);
-- test results: Error Code: 3819. Check constraint 'employee_bonus_commission_ck' is violated.

-- invalid test:
		insert into employee (employee_id, first_name, middle_initial, last_name, birth_date,
		soc_sec_no, hire_date, work_dept_id, job_id, salary, bonus, commission) 
		values (107, 'robert', null,'lewandoski', '1985-08-23', 565871573, '2012-08-23', 1,3,60000,500,null);
-- test results: Error Code: 3819. Check constraint 'employee_bonus_commission_ck' is violated.

-- valid test:
		insert into employee (employee_id, first_name, middle_initial, last_name, birth_date,
		soc_sec_no, hire_date, work_dept_id, job_id, salary, bonus, commission) 
		values (107, 'robert', null,'lewandoski', '1985-08-23', 565871573, '2012-08-23', 1,3,60000,null,null);
-- test results: 1 row(s) affected

-- valid test:
		insert into employee (employee_id, first_name, middle_initial, last_name, birth_date,
		soc_sec_no, hire_date, work_dept_id, job_id, salary, bonus, commission) 
		values (108, 'Ana', null,'ivanovic', '1985-08-23', 568871573, '2012-08-23', 1,3,60000,600,500);
-- test results: 1 row(s) affected


-- Constraint test 9
select * from car;
-- Purpose: Confirm car for sale should be 'N' if unknown in car table.
-- valid test:
        insert into car(car_id,make,model,color,height, car_length, width, engine_cc, car_for_sale)
		values(2000,'Toyota','Avalon', 'quartzite grey', 4830, 4708, 2081,6410, default);
-- test results: 1 row(s) affected 

-- Constraint test 10
-- Purpose: Confirm car for sale should be 'N' or 'Y'
-- valid test:
        insert into car(car_id,make,model,color,height, car_length, width, engine_cc, car_for_sale)
		values(2000,'Toyota','Avalon', 'quartzite grey', 4830, 4708, 2081,6410, 'Z');
-- test results: Error Code: 3819. Check constraint 'car_car_for_sale_ck' is violated.

-- Constraint test 11
-- Purpose: Confirm on_road_price should be greater than price in sales invoice table.
-- invalid test:
		insert into sales_invoice(invoice_id, date, price, on_road_price, car_id,customer_id,salesperson_id,vin_number)
		values(default, default, 905000, 60000, 2050, 1, 210,'12HJ5541256554K25');
-- test results: Error Code: 3819. Check constraint 'sales_invoice_on_road_price' is violated.


-- Constraint Test 12
-- Purpose: Confirm foreign key constraint car_id on sales invoice table
-- Invalid test
-- Expected_results: Error
-- Action:
		insert into sales_invoice(invoice_id, date, price, on_road_price, car_id,customer_id,salesperson_id,vin_number)
		values(default, default, 905000, 1000000, 100, 1, 210,'12HJ0001056554K25');
-- test results: Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`car_dealership`.`sales_invoice`, CONSTRAINT `sales_invoice_car_id_fk` FOREIGN KEY (`car_id`) REFERENCES `car` (`car_id`))

-- Constraint Test 13
-- Purpose: Confirm foreign key constraint customer_id on sales invoice table
-- Invalid test
-- Expected_results: Error
-- Action:
		insert into sales_invoice(invoice_id, date, price, on_road_price, car_id,customer_id,salesperson_id,vin_number)
		values(default, default, 905000, 1000000, 2050, 300, 210,'12HJ0001056554K25');
-- test results: Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`car_dealership`.`sales_invoice`, CONSTRAINT `sales_invoice_customer_id_fk` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`))

-- Constraint Test 14
-- Purpose: Confirm foreign key constraint salesperson_id on sales invoice table
-- Invalid test
-- Expected_results: Error
-- Action:
		insert into sales_invoice(invoice_id, date, price, on_road_price, car_id,customer_id,salesperson_id,vin_number)
		values(default, default, 905000, 1000000, 2050, 1, 333,'12HJ0001056554K25');
-- test results: Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`car_dealership`.`sales_invoice`, CONSTRAINT `sales_invoice_salesperson_id_fk` FOREIGN KEY (`salesperson_id`) REFERENCES `employee` (`employee_id`))


-- Constraint Test 15
-- Purpose: Confirm unique key constraint on phone_number in customer table
-- Invalid test
-- Expected_results: Error
-- Action:
		insert into customer(customer_id, first_name, last_name, phone_number, address,zip)
		values(244, 'diana', 'holland', 5541256, '19 huntington road', 'M1K4M6');
-- test results: Error Code: 1062. Duplicate entry '423242323' for key 'customer.customer_phone_number'

-- Constraint Test 16
-- Purpose: Confirm foreign key constraint zip on customer table
-- Invalid test
-- Expected_results: Error
-- Action:
		insert into customer(customer_id, first_name, last_name, phone_number, address,zip)
		values(2433, 'cristiano', 'Ronaldo', 423242323, '33 Falmouth Ave', 'JPT4M6');
-- test results: Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`car_dealership`.`customer`, CONSTRAINT `customer_zip_fk` FOREIGN KEY (`zip`) REFERENCES `zip` (`zip`))

-- Constraint Test 17
-- Purpose: Confirm foreign key constraint car_id on service ticket table
-- Invalid test
-- Expected_results: Error
-- Action:
		insert into service_ticket (service_ticket_id, car_id, customer_id, date_received, issues, date_returned)
		values (0101, 1109, 2432, default, 'something problem on brake and wiper', null);
-- test results:Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`car_dealership`.`service_ticket`, CONSTRAINT `service_ticket_car_id_fk` FOREIGN KEY (`car_id`) REFERENCES `car` (`car_id`))


-- Constraint Test 18
-- Purpose: Confirm foreign key constraint customer_id on service ticket table
-- Invalid test
-- Expected_results: Error
-- Action:
		insert into service_ticket (service_ticket_id, car_id, customer_id, date_received, issues, date_returned)
		values (1001, 2057, 6000, default, 'something problem on brake and wiper', null);
-- test results: Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`car_dealership`.`service_ticket`, CONSTRAINT `service_ticket_customer_id_fk` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`))

-- Constraint Test 19
-- Purpose: Confirm date_received as current date as default in service ticket table
-- valid test
-- Expected_results: 1 row inserted
-- Action:
		insert into service_ticket (service_ticket_id, car_id, customer_id, date_received, issues, date_returned)
		values (0105, 2055, 1, default, 'something problem on brake and wiper', null);
-- test results: 1 row(s) affected
 
-- Constraint Test 20
-- Purpose: Confirm foriegn key service_ticket_id in service mechanic detail table
-- invalid test
-- Expected_results: Error
-- Action:
		insert into service_mechanic_detail (service_ticket_id, mechanic_id, hours, comment, rate_per_hour)
		values (110,999,4,'oil change needed', 15);
-- test results: Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`car_dealership`.`service_mechanic_detail`, CONSTRAINT `service_mechanic_detail_service_ticket_id_fk` FOREIGN KEY (`service_ticket_id`) REFERENCES `service_ticket` (`service_ticket_id`))

 -- Constraint Test 21
-- Purpose: Confirm foriegn key mechanic_id in service mechanic detail table
-- invalid test
-- Expected_results: Error
-- Action:
		insert into service_mechanic_detail (service_ticket_id, mechanic_id, hours, comment, rate_per_hour)
		values (7,505,4,'tyre puncture', 15);
-- test results: Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`car_dealership`.`service_mechanic_detail`, CONSTRAINT `service_mechanic_detail_mechanic_id_fk` FOREIGN KEY (`mechanic_id`) REFERENCES `employee` (`employee_id`))

 -- Constraint Test 22
-- Purpose: Confirm foriegn key car_id in part table
-- invalid test
-- Expected_results: Error
-- Action:
		insert into part (car_id, vendor_id, part_description,part_cost)
		values(1103,2, 'alternators', 405);
-- test results: Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`car_dealership`.`part`, CONSTRAINT `part_car_id_fk` FOREIGN KEY (`car_id`) REFERENCES `car` (`car_id`))

-- Constraint Test 23
-- Purpose: Confirm foriegn key vendor_id in part table
-- invalid test
-- Expected_results: Error
-- Action:
		insert into part (car_id, vendor_id, part_description,part_cost)
		values(2050,4, 'alternators', 405);
-- test results: Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`car_dealership`.`part`, CONSTRAINT `part_vendor_id_fk` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`vendor_id`))


-- Constraint Test 24
-- Purpose: Confirm foreign key constraint work_dep_id on employee table
-- valid test
-- Expected results: Insert add new row to employee table
-- Action:
		insert into employee (employee_id, first_name, middle_initial, last_name, birth_date,
		soc_sec_no, hire_date, work_dept_id, job_id, salary, bonus, commission) 
		values (997, 'jose', null,'m', '1990-08-23', 965418573, '2022-06-08', 1,2,70000,null,null);
-- test results: 1 row inserted 

-- Invalid test
-- Expected_results: Insert fails with SQL0803 duplicate key error.
-- Action:
		insert into employee (employee_id, first_name, middle_initial, last_name, birth_date,
		soc_sec_no, hire_date, work_dept_id, job_id, salary, bonus, commission) 
		values (100, 'jose', null,'m', '1990-08-23', 965418573, '2022-06-08', 6,2,70000,null,null);
-- test results: Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`car_dealership`.`employee`, CONSTRAINT `employee_work_dept_id_fk` FOREIGN KEY (`work_dept_id`) REFERENCES `department` (`department_id`))

-- Constraint Test 25
-- Purpose: Confirm not null constraint on employee table on first_name attribute
-- invalid test
-- Expected results: error
-- Action:
		insert into employee (employee_id, first_name, middle_initial, last_name, birth_date,
		soc_sec_no, hire_date, work_dept_id, job_id, salary, bonus, commission) 
		values (995, null, null,'sherchan', '1995-08-23', 5418573, '2022-06-08', 1,2,70000,null,null);
-- test results: Error Code: 1048. Column 'first_name' cannot be null

-- valid test
-- Expected_results: 1 rows inserted.
-- Action:
		insert into employee (employee_id, first_name, middle_initial, last_name, birth_date,
		soc_sec_no, hire_date, work_dept_id, job_id, salary, bonus, commission) 
		values (995, 'Roshid', null,'sherchan', '1995-08-23', 5418573, '2022-06-08', 1,2,70000,null,null);
-- test results:1 row(s) affected




