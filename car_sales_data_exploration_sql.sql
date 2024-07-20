-- Data Overview
-- Check for any rows where 'make' is NULL
SELECT *
FROM muzammildb.dbo.cars_sales
WHERE make IS NULL;

-- Display all records from the original table
SELECT *
FROM muzammildb.dbo.cars_sales;

-- Creating a Duplicate Table
-- Create an empty duplicate table 'cars_data' with the same structure as 'cars_sales'
SELECT *
INTO cars_data
FROM muzammildb.dbo.cars_sales
WHERE 1 = 0;

-- Display structure of the new 'cars_data' table
SELECT *
FROM muzammildb.dbo.cars_data;

-- Insert data into the new 'cars_data' table
INSERT INTO cars_data
SELECT *
FROM muzammildb.dbo.cars_sales;

-- Data Cleaning
-- Count records where 'make' is NULL in the cleaned table
SELECT COUNT(*)
FROM muzammildb.dbo.cars_data
WHERE make IS NULL;

-- Remove rows with NULL values in critical columns
DELETE
FROM muzammildb.dbo.cars_data
WHERE make IS NULL
   OR model IS NULL
   OR trim IS NULL
   OR body IS NULL
   OR transmission IS NULL
   OR condition IS NULL
   OR odometer IS NULL
   OR color IS NULL
   OR interior IS NULL;

-- Sales Analysis
-- 1. Total Cars Sold
SELECT make, model, COUNT(*) AS total_cars_sold
FROM muzammildb.dbo.cars_data
GROUP BY model, make
ORDER BY total_cars_sold DESC;

-- 2. Sales Revenue
SELECT make, model, COUNT(*) AS total_sales, SUM(sellingprice) AS sales_revenue
FROM muzammildb.dbo.cars_data
GROUP BY model, make
ORDER BY sales_revenue DESC;

-- Average Selling Price
SELECT make, model, COUNT(*) AS total_sales, AVG(sellingprice) AS avg_selling_price
FROM muzammildb.dbo.cars_data
GROUP BY model, make
ORDER BY avg_selling_price DESC;

-- Condition and Odometer Insights
-- 1. Average Condition of Cars Sold
SELECT make, model, COUNT(*) AS total_sales, AVG(condition) AS avg_condition_car_sold
FROM muzammildb.dbo.cars_data
GROUP BY model, make
ORDER BY avg_condition_car_sold DESC;

-- 2. Average Odometer Reading
SELECT make, model, COUNT(*) AS total_sales, AVG(odometer) AS avg_odometer_reading
FROM muzammildb.dbo.cars_data
GROUP BY model, make
ORDER BY avg_odometer_reading DESC;

-- 3. Effect of Condition on Selling Price
SELECT condition, AVG(sellingprice) AS avg_selling_price
FROM muzammildb.dbo.cars_data
GROUP BY condition
ORDER BY condition DESC;

-- Popular Color and Interior Combinations
SELECT color, interior, COUNT(*) AS count
FROM muzammildb.dbo.cars_data
GROUP BY color, interior
ORDER BY count DESC;

-- Popular Color, Interior, and Car Model Combinations
SELECT make, model, color, interior, COUNT(*) AS count
FROM muzammildb.dbo.cars_data
GROUP BY make, model, color, interior
ORDER BY count DESC;

-- Interior Combination vs Selling Price
SELECT color, interior, AVG(sellingprice) AS avg_selling_price
FROM muzammildb.dbo.cars_data
GROUP BY color, interior
ORDER BY avg_selling_price DESC;

-- Sales Statistics by State
-- Impact of Location on Selling Price
SELECT state, COUNT(*) AS total_cars_sold, SUM(sellingprice) AS total_revenue, AVG(sellingprice) AS avg_revenue
FROM muzammildb.dbo.cars_data
GROUP BY state
ORDER BY total_cars_sold DESC;

-- Seller Analysis
-- Top Seller
SELECT TOP 1
    seller,
    COUNT(*) AS total_sales
FROM muzammildb.dbo.cars_data
GROUP BY seller
ORDER BY total_sales DESC;

-- Average Selling Price by Seller
SELECT
    seller,
    AVG(sellingprice) AS average_selling_price
FROM muzammildb.dbo.cars_data
GROUP BY seller
ORDER BY average_selling_price DESC;

-- Seller Analysis: Detailed Statistics
SELECT
    seller,
    COUNT(*) AS total_sales,
    AVG(sellingprice) AS average_selling_price,
    MIN(sellingprice) AS min_selling_price,
    MAX(sellingprice) AS max_selling_price,
    STDEV(sellingprice) AS std_dev_selling_price
FROM muzammildb.dbo.cars_data
GROUP BY seller
ORDER BY average_selling_price DESC;

-- Transmission Analysis
-- Transmission Type vs Sales and Pricing
SELECT
    transmission,
    COUNT(*) AS total_sales,
    AVG(sellingprice) AS average_selling_price,
    MIN(sellingprice) AS min_selling_price,
    MAX(sellingprice) AS max_selling_price,
    STDEV(sellingprice) AS std_dev_selling_price
FROM muzammildb.dbo.cars_data
GROUP BY transmission
ORDER BY average_selling_price DESC;

-- Transmission Type vs Selling Price
SELECT
    transmission,
    AVG(sellingprice) AS average_selling_price,
    MIN(sellingprice) AS min_selling_price,
    MAX(sellingprice) AS max_selling_price,
    STDEV(sellingprice) AS std_dev_selling_price
FROM muzammildb.dbo.cars_data
GROUP BY transmission
ORDER BY average_selling_price DESC;
