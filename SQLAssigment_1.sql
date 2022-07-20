CREATE DATABASE MANUFACTURER;

USE Manufacturer

CREATE SCHEMA PRODUCT;

CREATE SCHEMA Supplier;

CREATE SCHEMA Component;


drop table product.product;

CREATE TABLE [PRODUCT].[Product](
    [prod_id][int] Not null,
    [prod_name] [varchar](50) not null,
    [quantity] [int] not null,
    PRIMARY KEY ([prod_id])
);


CREATE TABLE [Supplier].[Supplier](
    [supp_id][int] not NULL,
    [supp_name] [varchar](50) not null,
    [supp_location] [varchar](50) not null,
    [supp_country][varchar](50) not null,
    [is_active] [bit] not null
    primary key ([supp_id])
);


CREATE TABLE [Component].[Component](
    [comp_id][int] ,
    [comp_name] [varchar](50),
    [description] [varchar](50),
    [quantity_comp] [int]
    PRIMARY KEY ([comp_id])
   
);


drop table product.prod_comp;

CREATE TABLE [Product].[Prod_comp](
    [prod_id] int  not null,
    [comp_id] [int] not null,
    [quantity_comp] [int] not null,
    PRIMARY KEY ([prod_id], [comp_id])
   
);

Alter table product.prod_comp add CONSTRAINT FK1 FOREIGN KEY (prod_id)
    REFERENCES Product.product(prod_id);

Alter table product.prod_comp add CONSTRAINT FK2 FOREIGN KEY (comp_id)
    REFERENCES component.component(comp_id);    


 drop table [PRODUCT].[Prod_comp] ;   

-- CREATE TABLE [PRODUCT].[Prod_comp] (
 --   [prod_id]       INT NOT NULL,
  --  [comp_id]       INT NOT NULL,
  --  [quantity_comp] INT NULL,
 --   PRIMARY KEY ([prod_id], [comp_id]),
 --   CONSTRAINT [FK1] FOREIGN KEY ([prod_id]) REFERENCES [PRODUCT].[Prod_comp] ([prod_id]),
 --   CONSTRAINT [FK2] FOREIGN KEY ([comp_id]) REFERENCES [PRODUCT].[Prod_comp] ([comp_id])
--);   


CREATE TABLE [Component].[comp_supp](
    [supp_id][int] ,
    [comp_id] [int],
    [order_date] [date],
    [quantity] [int]
    PRIMARY KEY ([supp_id], [comp_id])
   
);


Alter table [Component].[comp_supp] add CONSTRAINT FK1 FOREIGN KEY (supp_id)
    REFERENCES supplier.supplier(supp_id);

Alter table [Component].[comp_supp] add CONSTRAINT FK2 FOREIGN KEY (comp_id)
    REFERENCES component.component(comp_id);  

 drop table Component.comp_supp;


 select * from component.comp_supp;
