use SampleRetail;

select distinct sc.customer_id, sc.first_name, sc.last_name, pp.product_name
FROM product.product as pp
inner join sale.order_item as soi
on pp.product_id = soi.product_id
inner join sale.orders as so
on so.order_id=soi.order_id
inner join sale.customer as sc
on sc.customer_id= so.customer_id
where pp.product_name like '2tb red 5400 rpm sata III 3.5 internal nas hdd'
order by sc.customer_id


--first product

select distinct sc.customer_id, sc.first_name, sc.last_name, pp.product_name as first_product
FROM product.product as pp
inner join sale.order_item as soi
on pp.product_id = soi.product_id
inner join sale.orders as so
on so.order_id=soi.order_id
inner join sale.customer as sc
on sc.customer_id= so.customer_id
where pp.product_name = 'Polk Audio - 50 W Woofer - Black'
order by sc.customer_id

--Second product

select distinct sc.customer_id, sc.first_name, sc.last_name, pp.product_name as second_product
FROM product.product as pp
inner join sale.order_item as soi
on pp.product_id = soi.product_id
inner join sale.orders as so
on so.order_id=soi.order_id
inner join sale.customer as sc
on sc.customer_id= so.customer_id
where pp.product_name = 'SB-2000 12 500W Subwoofer (Piano Gloss Black)'
order by sc.customer_id

--Third product 

select distinct sc.customer_id, sc.first_name, sc.last_name, pp.product_name as third_product
FROM product.product as pp
inner join sale.order_item as soi
on pp.product_id = soi.product_id
inner join sale.orders as so
on so.order_id=soi.order_id
inner join sale.customer as sc
on sc.customer_id= so.customer_id
where pp.product_name = 'Virtually Invisible 891 In-wall Speakers (Pair)'
order by sc.customer_id

--Merged all tables 

SELECT A.customer_id, A.first_name, A.last_name, FP.first_product, sp.second_product, tp.third_product
FROM (
select distinct sc.customer_id, sc.first_name, sc.last_name, pp.product_name
FROM product.product as pp
inner join sale.order_item as soi
on pp.product_id = soi.product_id
inner join sale.orders as so
on so.order_id=soi.order_id
inner join sale.customer as sc
on sc.customer_id= so.customer_id
where pp.product_name like '2tb red 5400 rpm sata III 3.5 internal nas hdd'
) as A
left join (
    select distinct sc.customer_id, sc.first_name, sc.last_name, pp.product_name as first_product
FROM product.product as pp
inner join sale.order_item as soi
on pp.product_id = soi.product_id
inner join sale.orders as so
on so.order_id=soi.order_id
inner join sale.customer as sc
on sc.customer_id= so.customer_id
where pp.product_name = 'Polk Audio - 50 W Woofer - Black'
) as FP
on A.customer_id=FP.customer_id
left join (
    select distinct sc.customer_id, sc.first_name, sc.last_name, pp.product_name as second_product
FROM product.product as pp
inner join sale.order_item as soi
on pp.product_id = soi.product_id
inner join sale.orders as so
on so.order_id=soi.order_id
inner join sale.customer as sc
on sc.customer_id= so.customer_id
where pp.product_name = 'SB-2000 12 500W Subwoofer (Piano Gloss Black)'
) as sp
on A.customer_id = sp.customer_id
left join (
    select distinct sc.customer_id, sc.first_name, sc.last_name, pp.product_name as third_product
FROM product.product as pp
inner join sale.order_item as soi
on pp.product_id = soi.product_id
inner join sale.orders as so
on so.order_id=soi.order_id
inner join sale.customer as sc
on sc.customer_id= so.customer_id
where pp.product_name = 'Virtually Invisible 891 In-wall Speakers (Pair)'
) as tp
on A.customer_id = tp.customer_id
order by A.customer_id

----Dogru olan

SELECT A.customer_id, A.first_name, A.last_name, REPLACE(ISNULL(FP.FIRST_PRODUCT,'NO'),'Polk Audio - 50 W Woofer - Black','YES') as First_product,
		REPLACE(ISNULL(SP.SECOND_PRODUCT, 'NO'),'SB-2000 12 500W Subwoofer (Piano Gloss Black)', 'YES') as Second_product,
        replace(ISNULL(TP.THIRD_PRODUCT, 'NO'),'Virtually Invisible 891 In-Wall Speakers (Pair)', 'YES') as Third_product
FROM (SELECT DISTINCT SC.customer_id, SC.first_name, SC.last_name, PP.product_name
	FROM product.product AS PP
	INNER JOIN sale.order_item AS SOI
	ON PP.product_id = SOI.product_id
	INNER JOIN sale.orders AS SO
	ON SO.order_id = SOI.order_id
	INNER JOIN sale.customer AS SC
	ON SC.customer_id = SO.customer_id
	WHERE PP.product_name = '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD') AS A
LEFT JOIN (SELECT DISTINCT SC.customer_id, SC.first_name, SC.last_name, PP.product_name AS FIRST_PRODUCT
	FROM product.product AS PP
	INNER JOIN sale.order_item AS SOI
	ON PP.product_id = SOI.product_id
	INNER JOIN sale.orders AS SO
	ON SO.order_id = SOI.order_id
	INNER JOIN sale.customer AS SC
	ON SC.customer_id = SO.customer_id
	WHERE PP.product_name = 'Polk Audio - 50 W Woofer - Black') as FP
ON A.customer_id = FP.customer_id
LEFT JOIN (SELECT DISTINCT SC.customer_id, SC.first_name, SC.last_name, PP.product_name AS SECOND_PRODUCT
FROM product.product AS PP
INNER JOIN sale.order_item AS SOI
ON PP.product_id = SOI.product_id
INNER JOIN sale.orders AS SO
ON SO.order_id = SOI.order_id
INNER JOIN sale.customer AS SC
ON SC.customer_id = SO.customer_id
WHERE PP.product_name = 'SB-2000 12 500W Subwoofer (Piano Gloss Black)') AS SP
ON A.customer_id=SP.customer_id
LEFT JOIN (SELECT DISTINCT SC.customer_id, SC.first_name, SC.last_name, PP.product_name AS THIRD_PRODUCT
FROM product.product AS PP
INNER JOIN sale.order_item AS SOI
ON PP.product_id = SOI.product_id
INNER JOIN sale.orders AS SO
ON SO.order_id = SOI.order_id
INNER JOIN sale.customer AS SC
ON SC.customer_id = SO.customer_id
WHERE PP.product_name = 'Virtually Invisible 891 In-Wall Speakers (Pair)') AS TP
ON A.customer_id=TP.customer_id
ORDER BY A.customer_id

