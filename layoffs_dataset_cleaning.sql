-- Data Cleaning
SELECT *
FROM layoffs;

-- 1. Remove Duplicates
-- 2. Standardize Data
-- 3. Null or blank values
-- 4. Remove any cols 

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;
ALTER TABLE layoffs_staging
DROP COLUMN source,
DROP COLUMN date_added;
WITH duplicate_cte AS
(
 SELECT *,
 ROW_NUMBER() OVER(
 PARTITION BY company, location, stage, funds_raised, total_laid_off, percentage_laid_off, industry, country, `date`) as row_num
 FROM layoffs_staging
)
SELECT *
FROM duplicate_cte;
DELETE
FROM duplicate_cte
WHERE row_num>1;
SELECT *
FROM duplicate_cte;




CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `total_laid_off` double DEFAULT NULL,
  `date` text,
  `percentage_laid_off` text,
  `industry` text,
  `stage` text,
  `funds_raised` text,
  `country` text,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
 PARTITION BY company, location, stage, funds_raised, total_laid_off, percentage_laid_off, industry, country, `date`) as row_num
 FROM layoffs_staging;
 SET SQL_SAFE_UPDATES = 0;

DELETE
 FROM layoffs_staging2
 WHERE row_num>1;
 SELECT *
FROM layoffs_staging2;
 
 
 -- Standardizing data
 
 SELECT company, TRIM(company)
 From layoffs_staging2;
 
 UPDATE layoffs_staging2
 SET company=TRIM(company);

SELECT industry
FROM layoffs_staging2
ORDER BY 1;

SELECT DISTINCT country
FROM layoffs_staging2
order by 1;

UPDATE layoffs_staging2
SET `date`=STR_TO_DATE(`date`,'%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoffs_staging2
WHERE company='Appsmith';

UPDATE layoffs_staging2
SET industry='Low code'
WHERE industry='';


