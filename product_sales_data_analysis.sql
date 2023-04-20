select * from [data_analysis_db].[dbo].[Sales$]

/* Total Sales Amount for each Product Type */

select sum(sales_amount) as Sales, product_type
from [data_analysis_db].[dbo].[Sales$]
group by product_type

/* Total no of Sales Amount for each month */

select sum(sales_amount) as Monthly_Sales, month_name 
from [data_analysis_db].[dbo].[Sales$]
group by month_name

/* Total Sales for each market in descending order*/

select sum(sales_amount) as Sales, markets_name
from [data_analysis_db].[dbo].[Sales$]
group by markets_name
order by markets_name desc

/* Total Sales for each Customer Type */

select sum(sales_amount) as Sales, customer_type
from [data_analysis_db].[dbo].[Sales$]
group by customer_type

/* Total Sales Amount for each Year */

select sum(sales_amount) as Yearly_Sales, year
from [data_analysis_db].[dbo].[Sales$]
group by year

/* Average Sales Amount for each Market Code */

select avg(sales_amount) as Sales_Average, market_code
from [data_analysis_db].[dbo].[Sales$]
group by market_code
order by market_code

/* Total Sales Amount in INR */

select sum(sales_amount) as Sales_in_INR
from [data_analysis_db].[dbo].[Sales$]
where currency='INR'

/* Total Sales Amount in USD */

select sum(sales_amount) as Sales_in_USD
from [data_analysis_db].[dbo].[Sales$]
where currency='USD'

/* Total Sales Amount in each Zone */

select sum(sales_amount) as Sales, zone
from [data_analysis_db].[dbo].[Sales$]
group by zone

/* Display the top 5 markets with the highest sales quantities for each month in 2018 */

select markets_name, sales_amount, month_name, year 
from (select *,
row_number() over(partition by year, month_name order by sales_amount desc) as rn
from [data_analysis_db].[dbo].[Sales$]
where year = '2018') sales
where rn<=5;

/* Calculate the percentage of sales made by each product type for each customer type and display them in a pivot table */

select product_type, customer_type, round(sum(sales_amount)*100/sum(sum(sales_amount)) over(partition by customer_type), 2) as percentage_sales
from [data_analysis_db].[dbo].[Sales$]
group by product_type, customer_type

/* Calculate the year-over-year growth rate for each market's total sales amount */

select markets_name, year, sum(sales_amount) as Yearly_Sales
from [data_analysis_db].[dbo].[Sales$]
group by year, markets_name
order by year