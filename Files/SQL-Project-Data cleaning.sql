# Project data cleaning with SQL
# Creator:Movahed Abdolahi
# Date: March 2025

-- Processes:
-- Make a copy on database
-- remove duplicates
-- standardize data
-- handle NULL or Blank
-- remove irrelevant columns


-- 1: Making a copy to avoid dropping data permanently by mistake

CREATE TABLE layoffs_clean
LIKE layoffs;

INSERT layoffs_clean
SELECT * 
FROM layoffs;

SELECT 
	*,
	ROW_NUMBER() over(PARTITION BY company, location, country, industry, total_laid_off, percentage_laid_off, `date`) as row_num
FROM layoffs_clean;


WITH duplicates_cte AS
(
SELECT 
	*,
	ROW_NUMBER() over(PARTITION BY company, location, country, industry, total_laid_off, percentage_laid_off, `date`, stage, funds_raised_millions) as row_num
FROM layoffs_clean
)
SELECT *
FROM duplicates_cte
WHERE row_num >1;


CREATE TABLE `layoffs_clean2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT layoffs_clean2
SELECT 
	*,
	ROW_NUMBER() over(PARTITION BY company, location, country, industry, total_laid_off, percentage_laid_off, `date`, stage, funds_raised_millions) as row_num
FROM layoffs_clean;

DELETE
FROM layoffs_clean2
WHERE row_num > 1;

SELECT *
FROM layoffs_clean2;

-- Standardizing data

SELECT 
	company, 
    trim(company)
FROM layoffs_clean2;

UPDATE layoffs_clean2
SET company = trim(company);

select distinct industry
from layoffs_clean2
order by 1;

select * 
from layoffs_clean2
where industry like '%rypto%';

update layoffs_clean2
set industry = 'Crypto'
where industry like 'Crypto%';

select distinct country
from layoffs_clean2
order by 1;

update layoffs_clean2
set country = 'United States'
where country like 'United States%';

select 
	`date`,
    str_to_date(`date`, '%m/%d/%Y')
from layoffs_clean2;

update layoffs_clean2
set `date` = str_to_date(`date`, '%m/%d/%Y');

alter table layoffs_clean2
modify column `date` DATE;

-- NULL and Blanks

select *
from layoffs_clean2
where total_laid_off is null
and percentage_laid_off is null;

select * 
from layoffs_clean2
where industry is null or industry = '';

update layoffs_clean2
set industry = null
where industry = '';

select 
	t1.industry,
    t2.industry
from layoffs_clean2 as t1
join layoffs_clean2 as t2
	on t1.company = t2.company
where t1.industry is null and t2.industry is not null;

update layoffs_clean2 as t1
join layoffs_clean2 as t2
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null and t2.industry is not null;

-- Removing nulls

select *
from layoffs_clean2
WHERE total_laid_off is null
and percentage_laid_off is null;

delete
from layoffs_clean2
where total_laid_off is null 
and percentage_laid_off is null;

alter table layoffs_clean2
drop column row_num;

select *
from	layoffs_clean2;






