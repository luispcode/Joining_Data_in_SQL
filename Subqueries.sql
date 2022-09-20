--Subqueries

--Subquery inside where

-- Select fields
select *
  -- From populations
  From populations
-- Where life_expectancy is greater than
Where life_expectancy > 1.15 * (select avg(life_expectancy)
   From populations
   where year =2015)
  AND year = 2015;


  -- Select fields
Select cities.name, cities.country_code , cities.urbanarea_pop
  -- From cities
  from cities
-- Where city name in the field of capital cities
Where cities.name IN
  -- Subquery
  (select countries.capital
   from countries)
ORDER BY urbanarea_pop DESC;


--Subquery inside select

SELECT countries.name AS country,
(SELECT count(*) 
FROM cities 
WHERE countries.code = cities.country_code) AS cities_num
FROM countries
ORDER BY cities_num DESC, country
LIMIT 9;

--Subquery inside from
-- Select fields
select countries.local_name, subquery.lang_num
  -- From countries
  from countries,
  	-- Subquery (alias as subquery)
  	(SELECT code, COUNT(*) AS lang_num
  	 FROM languages
  	 GROUP BY code) AS subquery
  -- Where codes match
  WHERE countries.code = subquery.code
-- Order by descending number of languages
order by subquery.lang_num desc;

--Advanced subquery

-- Select fields
SELECT name, continent, inflation_rate
  -- From countries
  FROM countries
	-- Join to economies
	INNER JOIN economies
	-- Match on code
	on countries.code = economies.code
  -- Where year is 2015
  WHERE year = 2015
    -- And inflation rate in subquery (alias as subquery)
    And inflation_rate IN(
        SELECT MAX(inflation_rate) AS max_inf
        FROM (
             SELECT name, continent, inflation_rate
             FROM countries
             INNER JOIN economies
             on countries.code = economies.code
             WHERE year = 2015) AS subquery
      -- Group by continent
        GROUP BY continent);

--Subquery challenge

-- Select fields
SELECT economies.code, inflation_rate, unemployment_rate
  -- From economies
  FROM economies
  -- Where year is 2015 and code is not in
  WHERE year = 2015 AND code not in
  	-- Subquery
  	(SELECT code
  	 FROM countries
  	 WHERE (gov_form = 'Constitutional Monarchy' OR gov_form LIKE '%Republic%'))
-- Order by inflation rate
ORDER BY inflation_rate;

--Final challenge

-- Select fields
SELECT DISTINCT(c.name), e.total_investment, e.imports
  -- From table (with alias)
  FROM countries AS c
    -- Join with table (with alias)
    LEFT JOIN economies AS e
      -- Match on code
      ON (c.code = e.code
      -- and code in Subquery
        AND c.code IN (
          SELECT l.code
          FROM languages AS l
          WHERE l.official = 'true'
        ) )
  -- Where region and year are correct
  WHERE region = 'Central America' AND year = 2015
-- Order by field
ORDER BY c.name;

Challenge (2)

-- Select fields
SELECT c.region, c.continent, avg(p.fertility_rate) AS avg_fert_rate
  -- From left table
  FROM countries AS c
    -- Join to right table
    INNER JOIN populations AS p
      -- Match on join condition
      ON c.code = p.country_code
  -- Where specific records matching some condition
  WHERE p.year = 2015
-- Group appropriately
GROUP BY c.region, c.continent
-- Order appropriately
ORDER BY avg_fert_rate;

--challenge (3)

-- Select fields
SELECT cities.name, cities.country_code, cities.city_proper_pop, cities.metroarea_pop,  
      -- Calculate city_perc
      cities.city_proper_pop / cities.metroarea_pop * 100 AS city_perc
  -- From appropriate table
  FROM cities
  -- Where 
  WHERE cities.name IN
    -- Subquery
    (SELECT countries.capital
     FROM countries
     WHERE (countries.continent = 'Europe'
        OR countries.continent LIKE '%America%'))
       AND cities.metroarea_pop IS NOT NULL
-- Order appropriately
ORDER BY city_perc DESC
-- Limit amount
LIMIT 10;