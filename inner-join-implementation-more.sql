-- #1
-- shows each customers credit card number along with their email, useful for payment information and contacting them.
select first_name, last_name, credit_card_number, email
from customer c
join credit_card cd
	on c.customer_id = cd.customer_id;
    
-- #2
-- Shows all customers with a membership and the date they joined, useful for easily seeing all the members.
select first_name, last_name, join_date
from customer c
join membership m
on c.membership_id = m.membership_id;

-- #3
-- Displays the firstname and last name of every customer along with the boot sizes and ski/snowboard lengths they rented/are renting.
-- Useful for seeing the sizes each customer is renting
select first_name, last_name, boot_size, length_cm
from customer c
join rental r
	on c.customer_id = r.customer_id
join rental_has_inventory ri
	on r.rental_id = ri.rental_id
join inventory i
	on ri.inventory_id = i.inventory_id;

-- #4
-- Displays the first name and last name of a customer with their pass and items rented/renting
-- Useful to see an easy summary of the passes and items a customer purchased and rented.
select first_name, last_name, pass_name, item_name
from customer c
join ski_pass sp
	on c.customer_id = sp.customer_id
join pass_type pt
	on sp.pass_type_id = pt.pass_type_id
join rental r
	on c.customer_id = r.customer_id
join rental_has_inventory ri
	on r.rental_id = ri.rental_id
join inventory i
	on ri.inventory_id = i.inventory_id;
