--Union

-- Select fields from 2010 table
select *
  -- From 2010 table
  from economies2010
	-- Set theory clause
	union all
-- Select fields from 2015 table
select *
  -- From 2015 table
  from economies2015
-- Order by code and year
order by code, year ;


-- Select field
select country_code
  -- From cities
  from cities
	-- Set theory clause
	union 
-- Select field
select code
  -- From currencies
  from currencies
-- Order by country_code
order by country_code;

--Union all (include duplicates)

-- Select fields
SELECT code, year
  -- From economies
  FROM economies
	-- Set theory clause
	union all
-- Select fields
SELECT country_code, year
  -- From populations
  FROM populations
-- Order by code, year
ORDER BY code, year;

--Intersect

-- Select fields
SELECT code, year
  -- From economies
  FROM economies
	-- Set theory clause
INTERSECT
-- Select fields
SELECT country_code, year
  -- From populations
  FROM populations
-- Order by code, year
ORDER BY code, year;


-- Select fields
Select name
  -- From countries
  From countries
	-- Set theory clause
	INTERSECT
-- Select fields
Select name
  -- From cities
  From cities;

  --Except

  -- Select field
SELECT cities.name
  -- From cities
  FROM cities
	-- Set theory clause
	except
-- Select field
SELECT countries.capital
  -- From countries
  FROM countries
-- Order by result
ORDER BY name ;


-- Select field
select capital
  -- From countries
  from countries
	-- Set theory clause
	except
-- Select field
select name
  -- From cities
  from cities
-- Order by ascending capital
order by capital ;


--Semi-join

SELECT DISTINCT name
  FROM languages
-- Where in statement
Where code in
  -- Subquery
  (SELECT code
   FROM countries
   WHERE region = 'Middle East')
-- Order by name
order by name;


--Diagnosing problems using anti-join

-- Select fields
select countries.code, countries.name
  -- From Countries
  from countries
  -- Where continent is Oceania
  Where continent = 'Oceania'
  	-- And code not in
  	and code not in
  	-- Subquery
  	(select code 
  	 from currencies);


--Set a theory query

-- Select the city name
select c1.name
  -- Alias the table where city name resides
  from cities AS c1
  -- Choose only records matching the result of multiple set theory clauses
  WHERE c1.country_code IN
(
    -- Select appropriate field from economies AS e
    SELECT e.code
    FROM economies AS e
    -- Get all additional (unique) values of the field from currencies AS c2  
    union
    SELECT c2.code
    FROM currencies AS c2
    -- Exclude those appearing in populations AS p
    except
    SELECT p.country_code
    FROM populations AS p
);