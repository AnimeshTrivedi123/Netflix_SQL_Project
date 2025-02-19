--Netflix Project
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
show_id VARCHAR(6),
type VARCHAR(10),
title VARCHAR(150),
director VARCHAR(300),
casts VARCHAR(1000),
country VARCHAR(150),
date_added VARCHAR(50),
release_year INT,
rating VARCHAR(10),
duration VARCHAR(50),
listed_in VARCHAR(100),
description VARCHAR(250)
);

SELECT * FROM netflix;
SELECT 
	COUNT(*) as total_content
from netflix;

SELECT 
	DISTINCT type
from netflix;

--15 Business Problem
--1. Count the number of movies & TV shows.
SELECT
	type,
	COUNT(*) as total_content
FROM netflix
GROUP BY type

--2.Find the most common rating for movies and TV shows

SELECT 
	type,
	rating
FROM

(SELECT
	type,
	rating,
	COUNT(*),
	RANK()OVER(PARTITION BY type ORDER BY COUNT(*)DESC) as ranking
FROM netflix
GROUP BY 1,2
) as t1
WHERE
	ranking=1


--3.List all movies released in specific year(e.g., 2020)
--filter 2020
--movies



SELECT * FROM netflix
WHERE type='Movie'
AND
release_year=2020


--4.Find the top 5 countries with the most content on Netflix
SELECT 
	UNNEST (STRING_TO_ARRAY(country,',')) as new_country,
	COUNT(show_id) as total_content
from netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5


--5.Identify the Longest movie
SELECT * FROM netflix
WHERE 
	type ='Movie'
	AND 
	duration=(SELECT MAX(duration) FROM netflix)


--6.Find content added in the last 5 years
SELECT
*
FROM netflix
WHERE 
	TO_DATE(date_added,'Month DD, YYYY')>= CURRENT_DATE - INTERVAL '5 years'



SELECT CURRENT_DATE-INTERVAL '5 years'


--7.Find all the movies/TV show by director 'Rajiv Chilaka'!
SELECT*FROM netflix
WHERE director ILIKE'%Rajiv Chilaka%'


--8.List all the TV shows with more than 5 seasons.
SELECT
	*
FROM netflix
WHERE 
	type='TV Show'
	AND
	SPLIT_PART(duration,' ',1)::numeric > 5 



--9.Count the number of content item in each genre
SELECT
UNNEST(STRING_TO_ARRAY(listed_in, ',')) as genre,
COUNT(show_id) as total_content
FROM netflix
GROUP BY 1


--10.Find each year and the average numbers of content release by INDIA on netflix.
--return top 5 year with hightest avg content release!

--total content 333/972
SELECT
	EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY'))  as Year,
	COUNT(*)as yearly_content,
	ROUND(
	COUNT(*)::numeric/(SELECT COUNT(*)FROM netflix WHERE country='India')::numeric *100
	,2)as avg_content_per_year

FROM netflix
WHERE country='India'
GROUP BY 1


--11.List all the movies that are documentaries
SELECT*FROM netflix
WHERE
listed_in ILIKE '%documentaries%'




--12.Find all the content without a director

SELECT*FROM netflix
WHERE
director IS NULL


















