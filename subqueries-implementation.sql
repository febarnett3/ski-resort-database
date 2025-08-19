use ski_resort;

-- get customers attending the next upcoming event
select c.first_name, c.last_name, e.event_name, e.location, e.event_date
from customer c
join customer_event ce on c.customer_id = ce.customer_id
join event e on ce.event_id = e.event_id
where e.event_date = (
        select min(event_date)
        from event
        where event_date >= curdate()
    );

-- Find customers who have never attended any event.
select c.first_name, c.last_name, c.email
from customer c
where c.customer_id not in (
        select customer_id
        from customer_event
);