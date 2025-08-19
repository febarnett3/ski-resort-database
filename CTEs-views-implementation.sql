-- 1. CTE Query
with rental_counts as (
    select r.customer_id, count(rhi.inventory_id) as total_items_rented
    from rental r
    join rental_has_inventory rhi on r.rental_id = rhi.rental_id
    group by r.customer_id
)
select c.first_name, c.last_name, rc.total_items_rented
from rental_counts rc
	join customer c on rc.customer_id = c.customer_id
where rc.total_items_rented > 2;

-- 2. Create the view
create view customer_rental_counts as
select r.customer_id, count(rhi.inventory_id) as total_items_rented
from rental r
	join rental_has_inventory rhi ON r.rental_id = rhi.rental_id
group by r.customer_id;

-- 3. Query the view
select c.first_name, c.last_name, v.total_items_rented
from customer_rental_counts v
join customer c ON v.customer_id = c.customer_id
where v.total_items_rented > 2;
