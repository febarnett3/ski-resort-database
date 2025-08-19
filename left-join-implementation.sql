-- This SQL query retrieves a list of customers along with their ski pass details, even if they haven't purchased a ski pass
select c.customer_id, c.first_name, c.last_name, sp.start_date, sp.end_date, pt.pass_name, pt.price
from customer c
	left join ski_pass sp
		on c.customer_id = sp.customer_id
	left join pass_type pt
		on sp.pass_type_id = pt.pass_type_id
order by customer_id;
    
    
-- This query retrieves all rental records along with customer and staff names, plus checkout and checkin times. 
-- It uses LEFT JOINs to include customer and staff data where available, while still showing rentals with 
-- missing related information. Results are sorted by rental ID.
select
	r.rental_id,
    c.first_name,
    c.last_name,
    s.first_name,
    s.last_name,
    r.checkout,
    r.checkin
from rental r
	left join customer c
		on r.customer_id = c.customer_id
	left join staff s
		on r.staff_id = s.staff_id
order by rental_id;
	

    

