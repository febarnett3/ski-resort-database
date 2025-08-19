select @@autocommit;
set autocommit = 0;

use ski_resort;

-- Query 1
select * from ski_pass;
start transaction;

insert into membership (join_date)
values (curdate());

insert into customer (membership_id, first_name, last_name, email, phone_number, address)
values (last_insert_id(), 'Fiona', 'Barnett', 'bar22058@byui.edu', '8122901411', '582 Hawthorne Heights');

insert into ski_pass (customer_id, pass_type_id, start_date, end_date, staff_id)
values (last_insert_id(), 2, curdate(), '2025-12-15', 3);

commit;
-- rollback;

-- Query 2
select * from rental_has_inventory;
start transaction;
insert into rental (customer_id, staff_id, checkout)
values (1, 2, curdate());
savepoint after_rental;
insert into rental_has_inventory (rental_id, inventory_id) values
(last_insert_id(), 3),
(last_insert_id(), 4);
commit;
-- rollback;
-- rollback to savepoint after_rental;

