/*-----------------------Session 2 - Report Data and group results-------------------------*/
/* 1. Filter results with WHERE
   2. Sort results with ORDER BY
   3. Transform results with STRING functions
   4. Changes result titles with ALIAS
   5. Filtering on DATE
   6. Aggregate results with GROUP BY and NUMERIC functions
   7. Unique values with DISTINCT
   8. Merge rows with GROUP BY and STRING functions
   9. Rank results with RANK and ROW NUMBER */



USE sakila;
SHOW TABLES;


/*------------------------------------1. Filter results with WHERE*/
SELECT * FROM actor;

/*a. Single condition using where clause*/
/*Capital letters*/
/*First name and Last name of actors whose first name is Penelope*/
SELECT 
    first_name, last_name
FROM
    actor
WHERE
    first_name = 'PENELOPE';
    
SELECT first_name, last_name FROM actor WHERE first_name = 'penelope';





SELECT 
    first_name, last_name
FROM
    actor
WHERE
    first_name = 'PeNELope';


/*All columns*/
SELECT * FROM actor WHERE first_name = 'penelope';

/*Small letter*/
SELECT FIRST_NAME, LAST_NAME
FROM ACTOR
WHERE first_name = "penelope"; 

/*Not equal to*/
SELECT first_name, last_name   
FROM actor                          
WHERE first_name <> 'PENELOPE';    



/* b. Multiple conditions*/
SELECT 
    actor_id, first_name, last_name
FROM
    actor
WHERE
    first_name = 'PENELOPE'
        AND actor_id < 10;


SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'PENELOPE' OR first_name = 'NICK';


/*Give me all the records from the actor table where first name is penelope or nick and the actor id
/*should be below 50*/

SELECT * FROM actor WHERE first_name = 'PENELOPE' OR first_name = 'NICK';

SELECT *
FROM actor
WHERE (first_name = 'PENELOPE' OR first_name = 'NICK') AND actor_id < 50;

/*Will this give the right answer??*/
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'penelope' OR first_name = 'nick' AND actor_id < 50;



/*The IN and NOT IN operator*/
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name IN ('PENELOPE', 'NICK', 'ED');

SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'PENELOPE' OR first_name = 'NICK' OR first_name = 'ED';

SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name NOT IN ('PENELOPE', 'NICK', 'ED');


/*Give me all the rows from the actor table where first name is matthew and last name is swank?*/
SELECT *
FROM actor
WHERE first_name = 'MATTHEW' AND last_name = 'SWANK';


/* c. LIKE and Wildcards*/
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name LIKE 'john%';

SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name LIKE 'john';

SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name LIKE '%l';  /*This is the letter l - Lion*/


SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name LIKE '%th%';


/* d. Using AND, OR and Wildcards together - Address table*/
SELECT * FROM address limit 10;

SELECT 
    *
FROM
    address
ORDER BY district;



SELECT * FROM address
WHERE district = 'alberta'
AND address LIKE '%lane%';

/*Give me all the records from address where district = 'Buenos Aires' and address should have
either "AL" or "EL"*/
SELECT 
    *
FROM
    address
WHERE
    (address LIKE '%AL%'
        OR address LIKE '%EL%')
        AND district = 'Buenos Aires';


SELECT * FROM address
WHERE district = 'Buenos Aires'
AND address LIKE '%Al%' OR '%El%';


SELECT *
FROM address
WHERE district = 'Buenos Aires'
AND (address LIKE '%El%' or address LIKE '%Al%');


/*------------------------------------2. Sorting results using ORDER BY*/
SELECT first_name, last_name          
FROM actor                            
WHERE first_name = 'PENELOPE'         
ORDER BY last_name;                  



SELECT first_name, last_name	
FROM actor
WHERE first_name = 'PENELOPE'
ORDER BY last_name DESC;


/* a. Write a query to display the top 20 first_name and last_name ordered by the first name 
in descending order*/
SELECT first_name, last_name	/*Second*/
FROM actor						/*First*/
ORDER BY first_name DESC		/*Third*/
LIMIT 20;						/*Fourth*/



/*------------------------------------3. Transform results with STRING functions*/
SELECT first_name, length(first_name)     /*Have you seen this function somewhere else? */
FROM actor;


SELECT 
    first_name,
    last_name,
    CONCAT(last_name, ', ', first_name),
    LENGTH(CONCAT(last_name, ', ', first_name))
FROM
    actor;
 

SELECT 
    first_name,
    last_name,
    CONCAT(last_name, ', ', first_name) AS full_name,
    LENGTH(CONCAT(last_name, ', ', first_name)) AS len_full_name
FROM
    actor
ORDER BY len_full_name DESC;


SELECT first_name, LOWER(first_name), last_name, UPPER(last_name)
FROM actor;


SELECT 
    first_name,
    last_name,
    LOWER(CONCAT(last_name, ', ', first_name)) AS lower_full_name,
    UPPER(CONCAT(last_name, ', ', first_name)) AS upper_full_name
FROM
    actor;
    
SELECT first_name, LEFT(first_name, 3), RIGHT(first_name, 5)
FROM actor;

SELECT first_name, last_name, LEFT(first_name, 4)
FROM actor
WHERE first_name = 'PENELOPE';



/*PENELOPE - only the first 4 characters*/

SELECT first_name, substring(first_name,1,5), SUBSTRING(first_name, 3, 5)
FROM actor;


SELECT first_name, SUBSTRING(first_name, 3)
FROM actor;

SELECT * FROM actor;







/*Give me the first name of all the records from the actor table in camel case
/* For e.g. PENELOPE becomes Penelope, MARK become Mark





/*PENELOPE
1. P     ENELOPE - Break the first letter and the rest of the letters - LEFT
2. P              - Keep the first letter as it is
3. enelope        - Convert the second part of the name to lower case - LOWER
4. Combine result of Step 2 and Step 4 
/* a. Write a query to capitalize only the first letter of the first name*/


SELECT 
    first_name,
    LEFT(first_name,1),
    LOWER(SUBSTRING(first_name,2)),
    CONCAT(UPPER(LEFT(first_name, 1)),
            LOWER(SUBSTRING(first_name, 2))) AS CamelCase_first_name
FROM
    actor;

SELECT first_name, SUBSTRING(first_name, 3, 4), SUBSTRING(first_name, 3)
FROM actor;


SELECT first_name,
concat(LEFT(first_name, 1), lower(substring(first_name,2,9))) FROM actor;    
    
SELECT first_name, TRIM(first_name)
FROM actor;


SELECT first_name, last_name
FROM actor
WHERE TRIM(first_name) = 'GRACE';



SELECT first_name, LOCATE('LOPE', first_name)
FROM actor;


/*------------------------------------4. Changes result titles/labels with ALIAS*/
SELECT * FROM actor;
SELECT * FROM address;
SELECT * FROM city;

SELECT 
    first_name,
    last_name,
    CONCAT(last_name, ', ', first_name) AS full_name,
    LENGTH(CONCAT(last_name, ', ', first_name)) AS len_full_name
FROM
    actor
WHERE full_name = 'AKHIL'
ORDER BY full_name DESC;
    
/* a. Can aliases be used in ORDER BY and WHERE?
Let us look at the SQL order of execution and decide if it can be/cannot be used


/*------------------------------------5. Filtering on DATE*/
SELECT * FROM actor;

SELECT 
    *,
    YEAR(last_update) AS year,
    MONTH(last_update) AS month,
    MONTHNAME(last_update) AS month_name,
    DAY(last_update) AS day,
    TIME(last_update) AS time,
    DATE(last_update) AS date
FROM
    actor;
    
    
SELECT * 
FROM actor 
WHERE YEAR(last_update) = 2006;


/*------------------------------------6. Aggregate results with GROUP BY and NUMERIC functions*/
USE sakila;

SELECT * FROM address;

SELECT COUNT(*) AS number_of_records
FROM address;

SELECT * FROM address;

SELECT 
    COUNT(*) AS number_of_records,
    COUNT(address) AS number_of_address,
    COUNT(address2) AS number_of_address2
FROM
    address;

SELECT * FROM address
order by district;

SELECT district, COUNT(address) AS cnt   /*Second*/ 
FROM address			/*First*/
GROUP BY district       /*Second*/
ORDER BY cnt DESC;      /*Third*/

SELECT district
FROM address
GROUP BY district;

SELECT 
    district, COUNT(*) AS cnt
FROM
    address
GROUP BY district
HAVING cnt > 5
ORDER BY cnt DESC;					

SELECT * from film;

SELECT district
FROM address
GROUP BY district;

SELECT DISTINCT district
FROM address;

SELECT district
FROM address
GROUP BY district;

SELECT district
FROM address
GROUP BY district;



/*------------------------------The group by as distinct*/
USE sakila;

SELECT * FROM film;

SELECT rating
FROM film
GROUP BY rating;

SELECT distinct rating
FROM film;

SELECT distinct rating
FROM film;


SELECT rating,
MIN(rental_duration), MAX(rental_duration), SUM(rental_duration), AVG(rental_duration)
FROM film
GROUP by rating;

SELECT rating, release_year, SUM(rental_duration), AVG(rental_duration), MIN(rental_duration),
MAX(rental_duration)
FROM film
GROUP BY rating, release_year;


/*------------------------------------7. Unique values with DISTINCT*/ 

SELECT DISTINCT district
FROM address;

SELECT district
FROM address
GROUP BY district;

SELECT DISTINCT district, address
FROM address
ORDER BY district;

SELECT COUNT(DISTINCT CONCAT(first_name,'//',last_update))
FROM actor;



/*------------------------------------8. Merge rows with GROUP BY and STRING functions*/
USE sakila;

SELECT * FROM address
ORDER BY district;
 
SELECT district, GROUP_CONCAT(phone)   /*This function is very specific to MySQL and might not be available in other SQL frameworks*/ 
FROM address
GROUP BY district;


SELECT 
    district,
    GROUP_CONCAT(phone
        ORDER BY phone ASC
        SEPARATOR ';') AS phone_nos
FROM
    address
GROUP BY district;


/*------------------------------------9. Rank results with RANK, DENSE RANK and ROW NUMBER*/
USE sakila;
SELECT * FROM film LIMIT 50;

SELECT title, rental_duration, DENSE_RANK() OVER (ORDER BY rental_duration DESC) as rnk
FROM film;

SELECT title, rental_duration, RANK() OVER (ORDER BY rental_duration DESC) as rnk
FROM film;

SELECT
      title,
      rental_duration,
      ROW_NUMBER() OVER (ORDER BY rental_duration DESC) as rnk
FROM film;


SELECT * FROM film;

SELECT rating
FROM film
GROUP BY rating;



SELECT DISTINCT rating
FROM film;

SELECT title, rating, rental_duration, DENSE_RANK() OVER (PARTITION BY rating ORDER BY rental_duration DESC) AS rnk
FROM film;

SELECT * FROM film;

SELECT 
       title, 
       rating, 
       (rental_duration*rental_rate) AS rental_amount, 
       DENSE_RANK() OVER (PARTITION BY rating ORDER BY (rental_duration*rental_rate) DESC) AS rnk
FROM film;



/*How to count the number of tables in a data base?*/

SELECT * FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'sakila';

SHOW TABLES;

SELECT 
    COUNT(*) AS totalnumberoftables /*Third, this will be executed*/
FROM
    INFORMATION_SCHEMA.TABLES  /* First this will be executed*/
WHERE
    TABLE_SCHEMA = 'sakila';   /*Second this will be executed*/
 