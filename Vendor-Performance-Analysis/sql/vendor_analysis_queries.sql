CREATE TABLE begin_inventory (
    inventoryid TEXT,
    store TEXT,
    city TEXT,
    brand TEXT,
    description TEXT,
    size TEXT,
    onhand INTEGER,
    price NUMERIC,
    startdate DATE
);

SELECT * FROM begin_inventory LIMIT 5;

SELECT COUNT(*) FROM begin_inventory;

SELECT * FROM begin_inventory
LIMIT 10;

SELECT COUNT(*) FROM begin_inventory;

CREATE TABLE end_inventory (
    inventoryid TEXT,
    store TEXT,
    city TEXT,
    brand TEXT,
    description TEXT,
    size TEXT,
    onhand INTEGER,
    price NUMERIC,
    startdate DATE
);

SELECT COUNT(*) FROM end_inventory;

SELECT * FROM end_inventory LIMIT 10;

DROP TABLE IF EXISTS purchases;

CREATE TABLE purchases (
    inventoryid TEXT,
    store TEXT,
    brand TEXT,
    description TEXT,
    size TEXT,
    vendor_number TEXT,
    vendor_name TEXT,
    purchase_price NUMERIC,
    purchase_date DATE
);

SELECT COUNT(*) FROM purchases;

SELECT * FROM purchases LIMIT 10;

DROP TABLE IF EXISTS purchases;

CREATE TABLE purchases (
    inventory_vendor_id TEXT,
    store_id TEXT,
    brand_id TEXT,
    description TEXT,
    size TEXT,
    quantity INTEGER,
    vendor_name TEXT,
    vendor_number TEXT,
    purchase_price NUMERIC,
    purchase_date TEXT
);

DROP TABLE IF EXISTS purchases;

CREATE TABLE purchases (
    inventoryid TEXT,
    store TEXT,
    brand TEXT,
    description TEXT,
    size TEXT,
    quantity INTEGER,
    vendor_name TEXT,
    vendor_number TEXT,
    purchase_price NUMERIC,
    purchase_date TEXT
);

DROP TABLE IF EXISTS purchases;

CREATE TABLE purchases (
    inventoryid TEXT,
    store TEXT,
    brand TEXT,
    description TEXT,
    size TEXT,
    vendornumber TEXT,
    vendorname TEXT,
    ponumber TEXT,
    podate TEXT,
    receivingdate TEXT,
    invoicedate TEXT,
    paydate TEXT,
    purchaseprice NUMERIC,
    quantity INTEGER,
    dollars NUMERIC,
    classification TEXT
);

DROP TABLE IF EXISTS purchases;

CREATE TABLE purchases (
    inventoryid TEXT,
    store TEXT,
    brand TEXT,
    description TEXT,
    size TEXT,
    vendornumber TEXT,
    vendorname TEXT,
    ponumber TEXT,
    podate TEXT,
    receivingdate TEXT,
    invoicedate TEXT,
    paydate TEXT,
    purchaseprice NUMERIC,
    quantity INTEGER,
    dollars NUMERIC,
    classification TEXT
);

SELECT COUNT(*) FROM purchases;

SELECT vendorname, SUM(dollars)
FROM purchases
GROUP BY vendorname
ORDER BY SUM(dollars) DESC
LIMIT 10;

DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    inventoryid TEXT,
    store TEXT,
    brand TEXT,
    description TEXT,
    size TEXT,
    salesquantity INTEGER,
    salesdollars NUMERIC,
    salesprice NUMERIC,
    salesdate TEXT,
    volume NUMERIC,
    classification TEXT,
    excisetax NUMERIC,
    vendorno TEXT,
    vendorname TEXT
);

COPY sales
FROM 'E:/Vendor_Performance_Analysis/raw_data/sales.csv'
DELIMITER ','
CSV HEADER;

SELECT SUM(salesdollars) FROM sales;

SELECT vendorname, SUM(salesdollars)
FROM sales
GROUP BY vendorname
ORDER BY SUM(salesdollars) DESC;





select count(*) from sales;

select sum(salesdollars) from sales;

select vendorname,
	sum(salesdollars) as revenue
from sales 
group by vendorname
order by revenue DESC
limit 10;

select brand,
	sum(salesdollars) as revenue
from sales
group by brand
ORDER BY revenue DESC
LIMIT 10;

select 
	s.vendorname,
	sum(s.salesdollars) as revenue,
	sum(p.dollars) as cost,
	(sum(s.salesdollars) - sum(p.dollars)) as profit,
	round(
		 (sum(s.salesdollars) - sum(p.dollars))
		 /NULLIF (sum(s.salesdollars),0)*100,
	     2
    ) As profit_margin_pct
from sales s
join purchases p 
on s.inventoryid = p.inventoryid
group by s.vendorname
order by profit_margin_pct DESC;

select 
	s.vendorname,
	sum(s.salesdollars) as recvenue,
	sum(p.dollars) as cost,
	sum(s.salesdollars) - sum(p.dollars) as profit
from sales s
join purchases p
on s.inventoryid = p.inventoryid
group by s.vendorname
order by profit DESC
limit 10;

SELECT
    COUNT(*)
FROM sales s
JOIN purchases p
ON s.inventoryid = p.inventoryid;

select 
	vendorname,
	sum(salesdollars) as revenue 
from sales
group by vendorname
order by revenue desc
limit 10;

select
	vendorname,
	sum(dollars) as cost
from purchases
group by vendorname
order by cost desc
limit 10;

with revenue as (
	select 
		trim(vendorname) as vendorname,
		sum(salesdollars) as revenue 
	from sales
	group by trim(vendorname)
),
cost as (
  select	
	trim(vendorname) as vendorname,
	sum(dollars) as cost
	from purchases
	group by trim(vendorname)
)
select 
	r.vendorname,
	r.revenue,
	c.cost,
	(r.revenue - c.cost) as profit,
	round(
		 ((r.revenue - c.cost) / nullif(r.revenue,0))*100,
		 2
	   ) as profit_margin_pct
from revenue r
join cost c
on r.vendorname = c.vendorname
order by profit desc
limit 10;

select 
	 vendorname,
	 sum(salesdollars) as revenue
from sales
group by vendorname
order by vendorname desc

select 
	 vendorname,
	   sum (dollars) as cost 
from purchases
group by vendorname
order by vendorname desc

with revenue as (
	select
		trim(vendorname) as vendorname,
		sum(salesdollars) as revenue 
	from sales
	group by trim (vendorname)
),
cost as (
	select
		trim(vendorname) as vendorname,
		sum(dollars) as cost
	from purchases
	group by trim (vendorname)
)
select
	r.vendorname,
	r.revenue,
	c.cost,
	(r.revenue - c.cost) as profit,
	round(
	(r.revenue - c.cost) / nullif (r.revenue,0)*100,
	2
	) as profit_margin_pct
from revenue r
join cost c
	on r.vendorname = c.vendorname
order by profit_margin_pct desc; 


with revenue as (
	select 
	trim(vendorname) as vendorname,
	sum(salesdollars) as revenue
	from sales
	group by trim(vendorname)
),
cost as(
	select 
	trim(vendorname) as vendorname,
	sum (dollars) as cost
	from purchases
	group by trim(vendorname)
)
select 
	  r.vendorname,
	  r.revenue,
	  c.cost,
	  (r.revenue - c.cost) as profit, 
	  round(
		(r.revenue - c.cost) / nullif(r.revenue, 0)*100,
	     2
	  ) as profit_margin_pct
from revenue r
join cost c
on r.vendorname = c.vendorname 
where (r.revenue - c.cost) < 0
order by profit_margin_pct asc;


with revenue as(
	  select trim(vendorname) as vendorname,
	  sum (salesdollars) as revenue
	  from sales
	  group by trim(vendorname)
),
cost as (
	  select trim(vendorname) as vendorname,
	  sum (dollars) as cost
	  from purchases
	  group by trim(vendorname)
)
select 
	r.vendorname,
	r.revenue,
	c.cost,
	(r.revenue - c.cost) as profit, 
	round(
	(r.revenue - c.cost) / nullif (r.revenue,0)*100,
	2
	) as profit_margin_pct

from revenue r
join cost c
on r.vendorname = c.vendorname 
where (r.revenue - c.cost) > 0
order by profit_margin_pct desc;


with revenue as(
	  select trim(vendorname) as vendorname,
	  sum (salesdollars) as revenue
	  from sales
	  group by trim(vendorname)
),
cost as (
	  select trim(vendorname) as vendorname,
	  sum (dollars) as cost
	  from purchases
	  group by trim(vendorname)
)
select 
	r.vendorname,
	r.revenue,
	c.cost,
	(r.revenue - c.cost) as profit, 
	round(
	(r.revenue - c.cost) / nullif (r.revenue,0)*100,
	2
	) as profit_margin_pct

from revenue r
join cost c
on r.vendorname = c.vendorname 
where (r.revenue - c.cost) > 0
order by profit_margin_pct desc
limit 10;


select vendorname, 
       sum(salesdollars) as revenue 
from sales
group by vendorname 
order by revenue desc
limit 10;

select 
	vendorname,
	sum(salesdollars) as revenue
from sales	
group by vendorname
order by revenue;

select 
	vendorname,
	sum(dollars) as cost
from purchases
group by vendorname
order by cost ;

with revenue as (
	select 
		trim(vendorname) as vendorname,
		sum(salesdollars) as revenue
	from sales
	group by trim (vendorname)
),

cost as (
	select
		trim(vendorname) as vendorname,
		sum(dollars) as cost
    from purchases
	group by trim(vendorname)
)


select
	r.vendorname,
	r.revenue,
	c.cost,
	(r.revenue - c.cost) as profit,
	round((r.revenue - c.cost) / nullif (r.revenue,0)*100,
	2) as profit_margin_pct
from revenue r
join cost c
on r.vendorname = c.vendorname
order by r.revenue desc
limit 10;


select 
	vendorname,
	sum(salesdollars) as revenue
from sales
group by vendorname
order by revenue;

select vendorname,
	sum(dollars) as cost
from purchases
group by vendorname
order by cost;

with revenue as (
	select
		trim(vendorname) as vendorname,
		sum(salesdollars) as revenue
from sales
group by trim(vendorname)
),

cost as (
	select 
		trim(vendorname) as vendorname,
		sum(dollars) as cost
from purchases
group by trim(vendorname)
),
base as(
	select
		r.vendorname,
		r.revenue,
		c.cost,
		(r.revenue - c.cost) as profit,
		round(
		(r.revenue - c.cost) / nullif (r.revenue,0)*100,
		2
		)as profit_margin_pct
from revenue r
join cost c
on r.vendorname = c.vendorname
)	
select 
	vendorname,
	revenue, 
	cost,
	profit,
	profit_margin_pct,
	case
		when profit < 0 then 'Loss Making'
		when revenue >= 10000000 and profit_margin_pct >= 25 then 'High Value Winner'
		when revenue >= 10000000 and profit_margin_pct < 25 then 'High Revenue But Low Efficiency'		
        when revenue < 10000000 and profit_margin_pct >= 25 then 'Small But Efficient'
		when revenue < 10000000 and profit_margin_pct < 25 then 'Low Value Vendor'
		ELSE 'Unclassified'
	end as vendor_segment
from base
order by revenue desc;



select 
	vendorname,
	sum(salesdollars) as revenue 
from sales
group by vendorname
order by revenue;

select 
	vendorname,
	sum(dollars) as cost
from purchases
group by vendorname
order by cost;

with revenue as(
	select
		trim(vendorname) as vendorname,
		sum(salesdollars) as revenue
		from sales
		group by trim(vendorname)
),

cost as (
	select 
		trim(vendorname) as vendorname,
		sum(dollars) as cost
		from purchases
		group by trim(vendorname)
),
base as(
	select 
		r.vendorname,
		r.revenue,
		c.cost,
		(r.revenue - c.cost) as profit
	from revenue r
	join cost c
	on r.vendorname = c.vendorname		
)
select 
	case
		when profit < 0 then 'Loss Making'
		else 'Profitable'
	end as vendor_status,
	count(*) as vendor_count,
	round(
		count(*) * 100.0 / 
		sum(count(*))over(),
		2
	) as pct_of_vendors
	from base
	group by vendor_status;


with revenue as(
	select
		trim(vendorname) as vendorname,
		sum (salesdollars) as revenue
		from sales
		group by trim(vendorname)
),
cost as(
	select
		trim(vendorname) as vendorname,
		sum(dollars) as cost
		from purchases
		group by trim(vendorname)
),
base as(
	select
		r.vendorname,
		r.revenue,
		c.cost,
		(r.revenue - c.cost) as profit,
		round(
		(r.revenue - c.cost) / nullif(r.revenue,0) * 100,
		2
		) as profit_margin_Pct
	from revenue r
	join cost c
	on r.vendorname = c.vendorname		
),
segmented as(
	select
		vendorname,
		case
			when profit_margin_pct < 20 then 'Low Margin'
			when profit_margin_pct between 20 and 35 then 'Medium Margin'
			else 'High Margin'
			end as margin_segment
			from base
)
select 
	margin_segment,
	count (*) as vendor_count,
	round(
		count(*)*100.0 /
		sum(count(*)) over(),
		2
	) as pct_of_vendors
	from segmented
	group by margin_segment
	order by vendor_count desc;
	


with revenue as(
	select 
		trim(vendorname) as vendorname,
		sum(salesdollars) as revenue
		from sales
		group by trim(vendorname)
),
cost as(
	select 
		trim(vendorname) as vendorname,
		sum(dollars) as cost
		from purchases
		group by trim(vendorname)
),

base as(
	select 
		r.vendorname,
		r.revenue,
		c.cost,
		(r.revenue - c.cost) as profit
	from revenue r
	join cost c
		on r.vendorname = c.vendorname
),

ranked_vendors as(
	select
		vendorname,
		profit,
		row_number()over(order by profit desc) as vendor_rank,
		count(*) over() as total_vendors
		from base
),

top_20_percent as (
	select * 
	from ranked_vendors
	where vendor_rank  <= total_vendors * 0.20
)
select 
	round(sum(profit),2) as top_20_profits,
	round(
		sum(profit) * 100.0/
		(select sum(profit) from base),
		2
	) as pct_of_total_profit
from top_20_percent;



with revenue as(
	select
		trim(vendorname) as vendorname,
		sum(salesdollars) as revenue
		from sales
		group by trim(vendorname)
),

cost as(
	select
		trim(vendorname) as vendorname,
		sum(dollars) as cost
		from purchases
		group by trim(vendorname)
),

base as(
	select 
		r.vendorname,
		r.revenue,
		c.cost,
		(r.revenue - c.cost) as profit
	from revenue r
	join cost c
		on r.vendorname = c.vendorname
),

ranked_vendors as (
	select
		vendorname,
		revenue, 
		profit,
		rank() over(order by revenue desc) as revenue_rank,
		rank () over(order by profit desc) as profit_rank
		from base
)

select
	vendorname,
	revenue,
	profit,
	revenue_rank,
	profit_rank,
	(revenue_rank - profit_rank) as rank_difference,
	case
		when(revenue_rank - profit_rank)>=5
			then 'Overperformer'
		when(revenue_rank - profit_rank)<= -5
			then 'Underperformer'
		else 'Expected Performer'
	end as performance_category
from ranked_vendors
order by rank_difference desc;



with revenue as(
	select 
		trim(vendorname) as vendorname,
		sum(salesdollars) as revenue
		from sales
		group by trim(vendorname)
),
cost as(
	select 
		trim(vendorname) as vendorname,
		sum(dollars) as cost
		from purchases
		group by trim(vendorname)
),
base as(
	select 
		r.vendorname,
		r.revenue,
		c.cost,
		(r.revenue - c.cost) as profit,
		round(
		((r.revenue - c.cost)*100.0) / nullif(r.revenue,0),
		2
		)as profit_margin_pct
	from revenue r
	join cost c
		on r.vendorname = c.vendorname
),
margin_rank as(
	select 
		vendorname,
		revenue,
		profit,
		profit_margin_pct,
		rank() over(order by profit_margin_pct desc) as high_margin_rank,
		rank() over(order by profit_margin_pct asc) as low_margin_rank
	from base
)
select 
	vendorname,
	revenue,
	profit,
	profit_margin_pct,
	case
		when high_margin_rank <= 10 then 'High Margin Outliers'
		when low_margin_rank <= 10 then 'Low Margin Outliers'
	end as outliers_type
from margin_rank
where high_margin_rank <=10
	or low_margin_rank <=10
order by profit_margin_pct desc;