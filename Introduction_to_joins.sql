--Inner join

-- Select name fields (with alias) and region 
SELECT cities.name as city, countries.name as country, countries.region
FROM cities
INNER JOIN countries
ON cities.country_code = countries.code;


-- Select fields with aliases
SELECT c.code as country_code, name, year, inflation_rate
FROM countries AS c
-- Join to economies (alias e)
INNER JOIN economies as e
-- Match on code
ON c.code = e.code;


-- Select fields
select c.code, c.name, c.region, p.year, p.fertility_rate
-- From countries (alias as c)
from countries as c
-- Join with populations (as p)
inner join populations as p
-- Match on country code
on c.code = p.country_code


--Inner join with using

-- Select fields
select c.name as country, c.continent, l.name as language, l.official
-- From countries (alias as c)
from countries as c
-- Join to languages (as l)
inner join languages as l
-- Match using code
using (code);

--Self-join

-- Select fields with aliases
SELECT p1.country_code,
       p1.size AS size2010, 
       p2.size AS size2015,
       -- Calculate growth_perc
       ((p2.size - p1.size)/p1.size * 100.0) AS growth_perc
-- From populations (alias as p1)
FROM populations AS p1
  -- Join to itself (alias as p2)
  INNER JOIN populations AS p2
    -- Match on country code
    ON p1.country_code = p2.country_code
        -- and year (with calculation)
        AND p1.year = p2.year - 5;

-- Case when and then

--first example
SELECT name, continent, code, surface_area,
    -- First case
    CASE WHEN surface_area > 2000000 THEN 'large'
        -- Second case
        WHEN surface_area > 350000 AND surface_area <= 2000000 THEN 'medium'
        -- Else clause + end
        ELSE 'small' END
        -- Alias name
        AS geosize_group
-- From table
FROM countries;

--Second example
SELECT country_code, size,
  CASE WHEN size > 50000000
            THEN 'large'
       WHEN size > 1000000
            THEN 'medium'
       ELSE 'small' END
       AS popsize_group
INTO pop_plus       
FROM populations
WHERE year = 2015;

-- Select fields
Select c.name, c.continent, c.geosize_group, p.popsize_group
-- From countries_plus (alias as c)
from countries_plus AS c
  -- Join to pop_plus (alias as p)
  inner Join pop_plus as p
    -- Match on country code
    on c.code = p.country_code
-- Order the table    
order by geosize_group;


