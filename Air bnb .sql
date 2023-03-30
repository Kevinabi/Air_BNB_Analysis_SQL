use Learnbay;

select * from listings;

--Data cleaning on SQL, by eliminating the columns that were not being used in the analysis:

ALTER TABLE listings
  DROP column name, last_review, reviews_per_month, license;

-- Average and sum of neighbour_group by price

select distinct(neighbourhood_group) as neighbourhood_group,  
				sum(price) as Amount_by_groups,	
				avg(price) as Avg_amt_by_groups		
				from listings group by neighbourhood_group;



--Grouping by neighbourhoods and price

select distinct(neighbourhood) as neighbourhood,
neighbourhood_group, sum(price) as amount,
avg(price) as average_amount
from listings group by neighbourhood,neighbourhood_group;



  SELECT DISTINCT neighbourhood, neighbourhood_group, 
AVG (price) OVER (PARTITION BY neighbourhood) AS avg_price
  FROM listings
  ORDER BY neighbourhood_group


-- No of neighbourhood groups:

 SELECT DISTINCT neighbourhood, neighbourhood_group, 
COUNT (id) AS no_of_airbnb
  FROM listings
GROUP BY neighbourhood, neighbourhood_group
HAVING neighbourhood = 'Fort Wadsworth' 
OR neighbourhood = 'Tribeca' 
OR neighbourhood = 'Prospect Park' 
OR neighbourhood = 'Theater District' 
OR neighbourhood = 'Flatiron District' 
OR neighbourhood = 'Midtown' 
OR neighbourhood = 'Port Richmond' 
OR neighbourhood = 'Soho' 
OR neighbourhood = 'Riverdale' 
ORDER BY no_of_airbnb


 SELECT DISTINCT neighbourhood, neighbourhood_group, 
COUNT (id) AS no_of_airbnb
  FROM listings
GROUP BY neighbourhood, neighbourhood_group
 
ORDER BY no_of_airbnb


-- Counting number of Airbnb per neighbourhood:
SELECT TOP 10 neighbourhood, neighbourhood_group, COUNT (id) AS number_of_airbnb
  FROM listings
  GROUP BY neighbourhood, neighbourhood_group
  HAVING COUNT (id) >= 160
  ORDER BY neighbourhood DESC;


--Revenue on the basis of neighbourhoods

select neighbourhood_group, sum(price) as total_revenue from listings group by neighbourhood_group order by sum(price) desc;

-- average rating of room types

select avg(number_of_reviews) as average_review, room_type, neighbourhood_group from listings group by room_type, neighbourhood_group order by avg(number_of_reviews) desc ;

--top 5 of airbnb basis of price and number

SELECT DISTINCT TOP 5 neighbourhood, neighbourhood_group, 
AVG (price) OVER (PARTITION BY neighbourhood) AS avg_price, COUNT (id) OVER (PARTITION BY neighbourhood) AS number_of_airbnb
  FROM listings
  GROUP BY price, neighbourhood, neighbourhood_group, id
  HAVING neighbourhood <> 'Fort Wadsworth'
  AND neighbourhood <> 'Broad channel'
  AND neighbourhood <> 'Prospect Park'
  AND neighbourhood <> 'Sea Gate'
  AND neighbourhood <> 'Port Richmond'
  ORDER BY avg_price DESC, number_of_airbnb


-- Number of Room Types available:

SELECT room_type, COUNT (room_type) AS number_of_airbnb
  FROM listings
  GROUP BY room_type
  ORDER BY room_type DESC


 -- Average price and number of airbnb available per room type:
  
  SELECT DISTINCT room_type, 
AVG (price) OVER (PARTITION BY room_type) AS avg_price, COUNT (id) OVER (PARTITION BY room_type) AS number_of_airbnb
  FROM listings
  GROUP BY price, room_type, id
  ORDER BY avg_price DESC, number_of_airbnb
	


-- Availability throughout the year:

SELECT DISTINCT neighbourhood_group, AVG (availability_365) AS availability
  FROM listings
  GROUP BY neighbourhood_group