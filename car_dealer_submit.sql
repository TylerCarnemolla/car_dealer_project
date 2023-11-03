
DROP TABLE IF EXISTS car CASCADE;
DROP TABLE IF EXISTS sales_person CASCADE;
DROP TABLE IF EXISTS invoice CASCADE;
DROP TABLE IF EXISTS customer CASCADE;
DROP TABLE IF EXISTS service CASCADE;
DROP TABLE IF EXISTS service_history CASCADE;
DROP TABLE IF EXISTS service_ticket CASCADE;
DROP TABLE IF EXISTS parts CASCADE;
drop table if exists mechanic cascade;


create table car(
car_id SERIAL primary key,
car_price NUMERIC(8,2),
serv_tick_id INTEGER,
service_hist_id INTEGER,
mechanic_id INTEGER,
make VARCHAR(20),
model VARCHAR(20),
foreign key (serv_tick_id) references service_ticket (serv_tick_id),

foreign key (mechanic_id) references mechanic (mechanic_id)

);

create table sales_person(
salesman_id SERIAL primary key,
first_name VARCHAR(50),
last_name VARCHAR(50)
);

create table invoice (
invoice_id SERIAL primary key,
part_cost NUMERIC(8,2),
labor NUMERIC(8,2),
car_price NUMERIC(8,2),
commision NUMERIC(8,2),
processing_fee NUMERIC(8,2)

);

create table customer(
customer_id SERIAL primary key,
cust_first VARCHAR(30),
cust_last VARCHAR(30),
cust_phone VARCHAR(30)
);

create table  service(
service_id SERIAL primary key,
labor NUMERIC(8,2),
work_needed VARCHAR(50),
part_id INTEGER,
foreign key (part_id) references parts (part_id)
);

create table service_history(
service_hist_id SERIAL primary key,
car_id INTEGER,
service_id INTEGER,
serv_tick_id INTEGER,

foreign key (car_id) references car(car_id),
foreign key (service_id) references service (service_id),
foreign key (serv_tick_id) references service_ticket (serv_tick_id)

);


create table service_ticket(
serv_tick_id SERIAL primary key,
car_id INTEGER,
work_needed VARCHAR
);

create table parts(
part_id SERIAL primary key,
part_cost numeric (8,2)
);

create table mechanic(
mechanic_id SERIAL primary key,
mach_first VARCHAR(50),
mach_last VARCHAR (50)
);





create or replace function add_car(_car_id NUMERIC(4) , _car_price NUMERIC(8,2), _make VARCHAR(20), _model VARCHAR(30) )
returns VOID
as $MAIN$
begin 
	insert into car(car_id, car_price, make, model)
	values (_car_id, _car_price, _make, _model);
	
end;
$MAIN$
language plpgsql;

select add_car(01, 20000, 'RAM', '1500');

select add_car(02, 60000, 'Dodge', 'Challenger');

select add_car(03,4000, 'Honda', 'Accord');

select add_car(04, 70100, 'BMW', 'M3');

create or replace function sales_guy( _salesman_id numeric(4), _first_name VARCHAR(50), _last_name VARCHAR(50))
returns VOID
as $MAIN$
begin 
	insert into sales_person(salesman_id,first_name,last_name)
	values (_salesman_id, _first_name, _last_name);
end;
$MAIN$
language plpgsql;

select sales_guy(01, 'Thomas', 'Allen');

select sales_guy(02, 'Brandon', 'Recardo');

select sales_guy( 03, 'Jennifer', 'Rodgie');

select sales_guy(04, 'Sarah', 'Bailey');

select * from sales_person



CREATE OR REPLACE FUNCTION add_service(_service_id NUMERIC, _labor NUMERIC)
RETURNS VOID AS $MAIN$
BEGIN
    INSERT INTO service (service_id, labor)
    VALUES (_service_id, _labor);
END;
$MAIN$
LANGUAGE plpgsql;


SELECT add_service(1, 22);
SELECT add_service(2, 25);
SELECT add_service(3, 18);
SELECT add_service(4, 15);

create or replace function add_customer(_customer_id numeric(4), _cust_first VARCHAR(50), _cust_last VARCHAR(50), _cust_phone NUMERIC(20))
returns VOID
as $MAIN$
begin 
	insert into customer(customer_id, cust_first, cust_last, cust_phone)
	values (_customer_id, _cust_first, _cust_last, _cust_phone);
end;
$MAIN$
language plpgsql;

select add_customer(01, 'Doug', 'Dungy', '8022541239');
select add_customer(02, 'Olivia', 'Potrust', '1238457869');
select add_customer(03, 'Reggy', 'Uburst', '6854951586');
select add_customer(04, 'Iggy', 'Higins', '24524564578');


CREATE OR REPLACE FUNCTION add_invoice_v2(_invoice_id NUMERIC(4), _commission NUMERIC(8,2), _processing_fee NUMERIC(8,2))
RETURNS VOID AS $MAIN$
BEGIN
    INSERT INTO invoice(invoice_id, commision, processing_fee)
    VALUES (_invoice_id, _commission, _processing_fee);
END;
$MAIN$
LANGUAGE plpgsql;


SELECT add_invoice_v2(1, 5000.00, 200.00);
SELECT add_invoice_v2(2, 4200.00, 180.00);
SELECT add_invoice_v2(3, 8000.00, 500.00);
SELECT add_invoice_v2(4, 1500.00, 120.00);

create or replace function add_service_history(_service_hist_id NUMERIC(4))
RETURNS VOID AS $MAIN$
BEGIN
    INSERT INTO service_history(service_hist_id)
    VALUES (_service_hist_id);
END;
$MAIN$
LANGUAGE plpgsql;

select add_service_history(012);
select add_service_history(013);
select add_service_history(014);
select add_service_history(015);



create or replace function add_serv_tick(_serv_tick_id NUMERIC(4), _work_needed VARCHAR(50))
RETURNS VOID AS $MAIN$
BEGIN
    INSERT INTO service_ticket(serv_tick_id, work_needed)
    VALUES (_serv_tick_id, _work_needed);
END;
$MAIN$
LANGUAGE plpgsql;

select add_serv_tick(01,'tire rotation');
select add_serv_tick(02, 'flat tire');
select add_serv_tick(03, 'restore AC');
select add_serv_tick(04, 'replace brake');



create or replace function add_mechanic(_mechanic_id numeric(4), _mach_first VARCHAR(50), _mach_last VARCHAR(50))
RETURNS VOID AS $MAIN$
BEGIN
    INSERT INTO mechanic(mechanic_id, mach_first, mach_last)
    VALUES (_mechanic_id, _mach_first, _mach_last);
END;
$MAIN$
LANGUAGE plpgsql;

select add_mechanic(01, 'Andrew', 'Miller');
select add_mechanic(02, 'Tom', 'Weast');
select add_mechanic(03, 'Freddy', 'Roblar');
select add_mechanic(04, 'Donny', 'Grey');

create or replace function add_parts(_part_id numeric(4), _part_cost NUMERIC(8,2))
RETURNS VOID AS $MAIN$
BEGIN
    INSERT INTO parts(part_id, part_cost)
    VALUES (_part_id, _part_cost);
END;
$MAIN$
LANGUAGE plpgsql;

select add_parts(01, 200);
select add_parts(02,500);
select add_parts (03,12);
select add_parts(04,52);



