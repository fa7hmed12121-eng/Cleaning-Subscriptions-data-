SELECT * FROM subscriptions_raw


-- Data Exploration 
-- how many countries, status, plan, payment method
SELECT trim(upper(plan)) planny, count (*) quantity
FROM subscriptions_raw
GROUP by planny

SELECT status, count (*) quantity
FROM subscriptions_raw
GROUP by status

SELECT country, count (*) quantity
FROM subscriptions_raw
GROUP by 1
ORDER by quantity

SELECT payment_method, count (*) quantity
FROM subscriptions_raw
GROUP by payment_method
ORDER by quantity

# Date columns
SELECT min(end_date) first_pay, max(end_date) last_pay
from subscriptions_raw

SELECT customer_id, customer_email, start_date, end_date, updated_at
FROM subscriptions_raw

SELECT start_date, count(*) total_rows
FROM subscriptions_raw
GROUP BY 1 

-- Numeric column

SELECT monthly_price, count(*) as total_rows
FROM subscriptions_raw
GROUP by 1 
ORDER by total_rows

--Multiple customers rows

Select * from(
SELECT customer_id,
count(*) total_rows
FROM subscriptions_raw
GROUP by 1)f

WHERE total_rows = 2

Select * 
FROM subscriptions_raw
WHERE customer_id = "CUST-6099"

/*--------------------------------------------
         Conclusion
   1.The string values has empty space, 
       messy letter format
   2.In date values we have different date 
      formates and empty values
   3.The numeric values are messy 
 --------------------------------------------*/


/* 
   Data Cleaing Process
   1.String Columns: standarizing values to follow 
     the same pattren
     a-country column 
     b-plan column
     c-Status column
     d-payment_method
     e-fill empty values with null 
   2.Format date column in one format type 
   3.Fix monthly_price to be normal and much 
     with subscription plan
*/

Select trim(plan), monthly_price
FROM subscriptions_raw

With Cleand_data AS (
Select f.subscription_id, customer_id, lower(customer_email), f.the_country, f.new_date, f.end_date,
    
    case 
    when f.new_status = 'active' then "Active"
    when f.new_status = 'canceled'or f.new_status = 'canceled' then "Cancelled"
    else 'Paused'
    end as status,
    
    f.planny, 
    payment, 
    f.updated_at,
    
    case
    when f.planny = 'FREE'  then 0.00
    when f.planny = 'PREMIUM' then 19.99
    ELSE 9.99
    END AS price

from
(Select subscription_id, customer_id, customer_email, 
    coalesce(
        STR_TO_DATE(start_date,  '%Y-%m-%d'),
        Str_to_date(start_date, "%d/%m/%Y")
        ) new_date, end_date,
    trim(lower(status)) new_status,
   
    case
    when country = 'IT' or country = 'ITALY' then 'Italy'
    When country = 'ireland' or country = 'IE' then 'Ireland'
    when country = 'U.K.' or country = 'United Kingdom'or country = 'uk' Then 'UK'
    WHen country = 'DE' or country = 'germany' then 'Germany'
    Else country
    end as the_country,
    
    upper(trim(plan)) planny, 
    case 
    When payment_method is Null or payment_method in('NULL', 'N/A') then 'Unknown'
    else payment_method
    End As payment, updated_at
    
    
FROM subscriptions_raw ) f)

## drop dublicate rows 

, cus_rank As (
SElect *,

   ROW_NUMBER() OVER(partition by customer_id order by updated_at DESC ) as row_num

from cleand_data
)
Select * FROM cus_rank

WHERE row_num =1 



