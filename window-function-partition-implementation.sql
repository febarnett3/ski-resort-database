use ski_resort;

select c.first_name, c.last_name, rental_price, sum(i.rental_price) over (partition by c.customer_id order by (i.rental_price)) as running_total
from customer c
	join rental r on r.customer_id = c.customer_id
    join rental_has_inventory h on r.rental_id = h.rental_id
    join inventory i on h.inventory_id = i.inventory_id;
    
select row_number() over (order by join_date) as join_date_rank, first_name, last_name, join_date
from membership m
	join customer c on m.membership_id = c.membership_id;