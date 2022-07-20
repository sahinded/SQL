/* Assignment-4 */

/* Generate a report including product IDs and discount effects on whether the increase
in the discount rate positively impacts the number of orders for the products. */

-- product_id ve discount'a göre order_count
SELECT SOI.product_id, SOI.discount , count(*) AS ORDER_COUNT
FROM sale.orders AS SO, sale.order_item AS SOI
WHERE SO.order_id = SOI.order_id
GROUP BY SOI.product_id, SOI.discount
ORDER BY SOI.product_id, SOI.discount

-- discount bazýnda order_count
SELECT SOI.discount , count(*) AS ORDER_COUNT
FROM sale.orders AS SO, sale.order_item AS SOI
WHERE SO.order_id = SOI.order_id
GROUP BY SOI.discount
ORDER BY SOI.discount


SELECT SOI.product_id, 
	count(SO.order_id) AS ORDER_COUNT, SOI.discount DENSE_RANK() OVER (PARTITION BY SOI.product_id ORDER BY count(SO.order_id))  as DISCOUNT_EFFECT
FROM sale.orders AS SO, sale.order_item AS SOI
WHERE SO.order_id = SOI.order_id

GROUP BY SOI.product_id, SOI.discount
ORDER BY SOI.product_id, SOI.discount



-- HOCA NIN ÇÖZÜMÜ
select  oi.product_id, count(oi.order_id), oi.discount , rank( ) over ( PARTITION by oi.product_id
                                                                        order by count(oi.product_id))  as DiscountEffect
from sale.order_item oi
join sale.orders so
on oi.order_id = so.order_id
GROUP by oi.product_id, oi.discount
ORDER by 1, 3

select  oi.product_id, count(oi.order_id) OrderCount, oi.discount ,
		rank( ) over ( PARTITION by oi.product_id order by count(oi.product_id))  as OrderCount_Rank,
		rank( ) over ( PARTITION by oi.product_id order by oi.discount)  as Discount_Rank
from sale.order_item oi
join sale.orders so
on oi.order_id = so.order_id
GROUP by oi.product_id, oi.discount
ORDER by 1, 3

SELECT SOI.product_id, count(*) AS ORDER_COUNT, avg(SOI.discount) avg_discount ,
	min(SOI.discount) min_discount, max(SOI.discount) max_discount,
	(max(SOI.discount)-min(SOI.discount)) discount_difference,
	(1.0*(max(SOI.discount)-min(SOI.discount))/ max(SOI.discount)) discount_rate
FROM sale.orders AS SO, sale.order_item AS SOI
WHERE SO.order_id = SOI.order_id
GROUP BY SOI.product_id
ORDER BY avg(SOI.discount)


SELECT SOI.product_id, count(*) AS ORDER_COUNT, max(SOI.discount) max_discount
FROM sale.orders AS SO, sale.order_item AS SOI
WHERE SO.order_id = SOI.order_id
GROUP BY SOI.product_id
ORDER BY max(SOI.discount)


SELECT SOI.product_id, count(SO.order_id) AS ORDER_COUNT
FROM sale.orders AS SO, sale.order_item AS SOI
WHERE SO.order_id = SOI.order_id
GROUP BY SOI.product_id
ORDER BY max(SOI.discount)

-- pivot table
select *
from (
		select	soi.[product_id],soi.discount,so.[order_id]
		from [sale].[order_item] soi ,[sale].[orders] so
		where soi.[order_id]=so.[order_id]
		group by soi.[product_id],soi.discount,so.[order_id]
	) A
PIVOT ( count(order_id)
for discount in ([0.05],[0.07],[0.10],[0.20])
)pvt



-- serdar hoca'nýn çözümü:

select A.product_id,	case
				when A.first_+A.second_+A.third_>0 then 'Positive'
				when A.first_+A.second_+A.third_< 0 then 'Negative'
				else 'Nötr'
			end discount_Effect

from
(
select *,	case
				when pvt.[0.07]-pvt.[0.05]> 0 then 1
				when pvt.[0.07]-pvt.[0.05]< 0 then -1
				else 0
			end first_
		,	case
				when pvt.[0.10]-pvt.[0.07]> 0 then 1
				when pvt.[0.10]-pvt.[0.07]< 0 then -1
				else 0
			end second_
		
		, case
				when pvt.[0.20]-pvt.[0.10]> 0 then 1
				when pvt.[0.20]-pvt.[0.10]< 0 then -1
				else 0
			end third_
from (
		select	soi.[product_id],soi.discount,so.[order_id]
		from [sale].[order_item] soi ,[sale].[orders] so
		where soi.[order_id]=so.[order_id]
		group by soi.[product_id],soi.discount,so.[order_id]
	) A
PIVOT ( 
count(order_id)
for discount in ([0.05],[0.07],[0.10],[0.20])
)pvt
) A