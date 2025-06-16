USE laptop_prices;

SELECT *
FROM laptopdata;

create table laptop_data
LIKE laptopdata;

SELECT *
FROM laptop_data;

INSERT laptop_data
SELECT *
FROM laptopdata;

with duplicate_cte as (
SELECT *,
row_number() OVER(
PARTITION BY Company, TypeName, Inches, ScreenResolution, `Cpu`, Ram, `Memory`, Gpu, OpSys, Weight, Price) as row_num
from laptop_data
)
SELECT *
FROM duplicate_cte;


SELECT *
FROM laptop_data2;

INSERT laptop_data2
select *,
ROW_NUMBER() OVER(
PARTITION BY Company, TypeName, Inches, ScreenResolution, `Cpu`, Ram, `Memory`, Gpu, OpSys, Weight, Price) as row_num
from laptop_data;

SELECT *
FROM laptop_data2;

DELETE 
FROM laptop_data2
WHERE row_num>1;

SELECT DISTINCT Company
FROM laptop_data2;

SELECT DISTINCT TypeName
FROM laptop_data2;

SELECT *
FROM laptop_data2
Where Inches='' or Inches is NULL;

SELECT DISTINCT OpSys
from laptop_data2;

SELECT *
FROM laptop_data2
Where Price='' or Price is NULL;

ALTER TABLE laptop_data2
DROP COLUMN row_num;