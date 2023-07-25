

--Select Data that we are going to be using 

SELECT 
	location, 
	date,
	total_cases, 
	total_deaths, 
	population
FROM owid_covid_data ocd 
ORDER BY location, date;


--Looking at total cases VS total deaths 
--Shows the likelihood of dying if you contract covid in united states

SELECT 	
	location,
	date,
	total_cases, 
	total_deaths, 
	(total_deaths / total_cases) * 100 as DeathPercentage
FROM owid_covid_data ocd 
WHERE location LIKE '%states%'
AND DeathPercentage <> 0
ORDER BY location, date desc;


--Looking at total cases vs population
--shows what percentage of population got covid

SELECT 	
	location,
	date,
	population,
	total_cases,  
	(total_cases / population) * 100 as PercentPopulationInfected
FROM owid_covid_data ocd 
WHERE location LIKE '%states%'
AND DeathPercentage <> 0
ORDER BY location, date;



--looking at countries with highest infection rate compared to population 

SELECT 	
	location,
	population,
	MAX(total_cases) AS HighestInfectionCount,  
	Max((total_cases / population)) * 100 as PercentPopulationInfected
FROM owid_covid_data ocd 
--WHERE location LIKE '%states%'
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC ;


--Showing countries with highest death count per population

SELECT 
	Location, 
	MAX(CAST(total_deaths as int)) as TotalDeathCount
FROM owid_covid_data ocd 
WHERE continent is not null
GROUP BY location 
ORDER BY TotalDeathCount DESC;


--Sorting data by continent 

SELECT 
	location 
	continent, 
	MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM owid_covid_data ocd 
WHERE continent IS NOT NOT NULL 
GROUP BY continent  
ORDER BY TotalDeathCount DESC;


--Global numbers 

SELECT 
	date, 
	SUM(new_cases) as total_cases, 
	SUM(CAST(new_deaths AS INT)) AS total_deaths,
	SUM(CAST(new_deaths AS INT)) / SUM(new_cases)*100 as DeathPercentage
FROM owid_covid_data ocd 
WHERE continent IS NOT NULL 
GROUP BY date 
ORDER BY 1,2;









