-- Analyzing data

select *
from layoffs_clean2;

select max(total_laid_off)
from	layoffs_clean2;

select *
from layoffs_clean2
where percentage_laid_off = 1
order by funds_raised_millions desc;

select company, sum(total_laid_off)
from layoffs_clean2
group by company
order by 2 desc;

select min(date), max(date)
from layoffs_clean2;


select industry, sum(total_laid_off)
from layoffs_clean2
group by industry
order by 2 desc;

select year(`date`), sum(total_laid_off) 
from layoffs_clean2
group by year(`date`)
order by 1 desc;

select stage, sum(total_laid_off) 
from layoffs_clean2
group by stage
order by 2 desc;

select 
	substring(`date`,1,7) as 'MONTH',
    sum(total_laid_off)
from layoffs_clean2
WHERE substring(`date`,1,7) IS NOT null
group by substring(`date`,1,7)
ORDER by 1 ASC;


WITH rolling_totals AS
(
select 
	substring(`date`,1,7) as month_name,
    sum(total_laid_off) as total_off
from layoffs_clean2
WHERE substring(`date`,1,7) IS NOT null
group by substring(`date`,1,7)
ORDER by 1 ASC
)
SELECT 
	month_name,
    total_off,
    sum(total_off) OVER(ORDER BY month_name) AS rolling_total
FROM rolling_totals;

select 
	company, 
	year(`date`), 
    sum(total_laid_off)
from layoffs_clean2
group by 
	company, 
    year(`date`)
order by 1;


WITH company_year (company, years, total_laid_off) AS	
(
select 
	company, 
	year(`date`), 
    sum(total_laid_off)
from layoffs_clean2
group by 
	company, 
    year(`date`)
), company_year_rank AS
(
SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM company_year
WHERE years is NOT NULL
)
SELECT *
FROM company_year_rank
WHERE Ranking <= 5;


WITH industry_year (industry, years, total_laid_off) AS	
(
select 
	industry, 
	year(`date`), 
    sum(total_laid_off)
from layoffs_clean2
group by 
	industry, 
    year(`date`)
), industry_year_rank AS
(
SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM industry_year
WHERE years is NOT NULL
)
SELECT *
FROM industry_year_rank
WHERE Ranking <= 5;





