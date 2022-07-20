
DROP Table Actions;  

CREATE TABLE Actions
  (Visitor_ID int identity(1,1),
   Adv_Type NVARCHAR(10),
   Action NVARCHAR(10)
  );

 select * from Actions 



Insert into Actions (Adv_Type, Action)
 VALUES ('A','Left')
        ,('A','Order')
        ,('B','Left')
        ,('A','Order')
        ,('A','Review')
        ,('A','Left')
        ,('B','Left')
        ,('B','Order')
        ,('B','Review')
        ,('A','Review')
        

Select * from Actions


SELECT Adv_Type,action, count(adv_type) as each_adv
FROM Actions
Group by Adv_Type,action


create VIEW table_1 as
SELECT Adv_Type,action, count(adv_type) as orders_each_adv
FROM Actions
where action='order'
Group by Adv_Type,action


create view table_2 as
SELECT  Adv_type, count(action) as count_total_action
FROM Actions
Group by Adv_type

--merge two tables
-- select * 
-- from table_1 

-- select * from table_2


create view table_3 as
select A.Adv_Type, A.action, A.orders_each_adv, B.count_total_action
from table_1 A
left join table_2 B
on A.Adv_Type=B.Adv_Type


select Adv_Type,cast(round(orders_each_adv*1.0/count_total_action,2) as decimal (18,2)) as Conversion_Rate
from table_3


















