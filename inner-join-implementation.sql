use ski_resort;

select first_name, last_name, pass_name,
case
	when duration_days >= 30 then 'Long-term pass'
    else 'Short-term pass'
end as pass_length_type
from customer c
join ski_pass p
	on c.customer_id = p.customer_id
join pass_type pt
	on p.pass_type_id = pt.pass_type_id;

select first_name, last_name, item_name, checkout, checkin,
case
	when checkin is null then 'Checked out'
	when datediff(checkin, checkout) < 3 then 'On time'
    else 'Late'
end as rental_status
from customer c
join  rental r
	on c.customer_id = r.customer_id
join rental_has_inventory ri
	on r.rental_id = ri.rental_id
join inventory i
	on ri.inventory_id = i.inventory_id;