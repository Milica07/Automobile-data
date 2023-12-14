/* Inspect the fuel_type column
According to the data’s description the fuel_type column should only 
have two unique string values: diesel and gas. */
SELECT 
  DISTINCT fuel_type
FROM 
  `banded-totality-398915.cars1.car_info` 
LIMIT 
  1000

/* Inspected column lenght with numerical data. */
SELECT
  MIN(length) AS min_length,
  MAX(length) AS max_length
FROM
  `banded-totality-398915.cars1.car_info`;

/* Checking to see if the num_of_doors column contains null values */
SELECT
  *
FROM
  `banded-totality-398915.cars1.car_info` 
WHERE 
  num_of_doors IS NULL;

/*  In order to fill in missing values, 
I used below query to update the table: */
UPDATE
  `banded-totality-398915.cars1.car_info` 
SET
  num_of_doors = "four"
WHERE
  make = "dodge"
  AND fuel_type = "gas"
  AND body_style = "sedan";

UPDATE
  `banded-totality-398915.cars1.car_info` 
SET
  num_of_doors = "four"
WHERE
  make = "mazda"
  AND fuel_type = "gas"
  AND body_style = "sedan";

/* Identify potential errors
It is practicable to use SELECT DISTINCT to check what values exist in a column. 
For example for checking num_of_cylinders column: */
SELECT
  DISTINCT num_of_cylinders
FROM
  `banded-totality-398915.cars1.car_info`;
/* For correcting misspelling run this query: */
UPDATE
  `banded-totality-398915.cars1.car_info`
SET
  num_of_cylinders = "two"
WHERE
  num_of_cylinders = "tow";

/* Next is checking column compression_ration. 
According to the data description, the compression_ration column values should range 
from 7 to 23. It is suitable to use MIN and MAX to check if that’s correct: */
SELECT
  MIN(compression_ratio) AS min_compression_ratio,
  MAX(compression_ratio) AS max_compression_ratio
FROM
  `banded-totality-398915.cars1.car_info`;

/* Query returns a maximum of 70. But this is an error because the maximum value 
in this column should be 23. So the 70 is most likely a 7.0. Solution could be running 
the above query again without the row with 70 to make sure that the rest of the values 
fall within the expected range of 7 to 23. */
SELECT
  MIN(compression_ratio) AS min_compression_ratio,
  MAX(compression_ratio) AS max_compression_ratio
FROM
  `banded-totality-398915.cars1.car_info`
WHERE
  compression_ratio <> 70;

/* Now the highest value is 23, which aligns with the data description. 
For checking the value 70 alignment with the sales manager is necessary. 
In this case the feedback from the sales manager was that this row was made in error 
and should be removed. Before deleting anything, double check is recommendable. 
Checking is recommendable since there could be many rows containing this erroneous value 
as a precaution so that you don’t end up deleting 50% of your data. For example, 
in case that there are too many (for instance, 20% of rows having the incorrect 70 value), 
then I would need to check back with the sales manager to inquire if these should be deleted 
or if the 70 should be updated to another value. 
For counting how many rows I would be deleting I have used next query: */
SELECT
  COUNT(*) AS num_of_rows_to_delete
FROM
  `banded-totality-398915.cars1.car_info`
WHERE
  compression_ratio = 70;

/* Since there is only one row with the erroneous 70 values, 
that row can be deleted using this query: */
DELETE
  `banded-totality-398915.cars1.car_info`
WHERE
  compression_ratio = 70;

/* Ensure consistency
Checking data for any inconsistencies that might cause errors. 
These inconsistencies can be tricky to spot — sometimes even something as simple 
as an extra space can cause a problem. For checking drive_weels column for inconsistencies 
have to be used query with a SELECT DISTINCT statement:*/
SELECT
  DISTINCT drive_wheels
FROM
  `banded-totality-398915.cars1.car_info`;

/* If this query shows that there are doubled equal values (e.g. extra space), 
LENGTH statement can be used to determine the length of how long each of these strings are: */
SELECT
  DISTINCT drive_wheels,
  LENGTH(drive_wheels) AS string_length
FROM
  `banded-totality-398915.cars1.car_info`;

/* According to results, some instances of the 4wd string have four characters 
instead of the expected three. In this case, TRIM function should be used to remove 
all extra spaces in the drive_wheels column: */
UPDATE
  `banded-totality-398915.cars1.car_info`
SET
  drive_wheels = TRIM(drive_wheels)
WHERE TRUE;

/* Then, the SELECT DISTINCT statement should be run again to ensure that there are 
only three distinct values in the drive_weels column: */
SELECT
  DISTINCT drive_wheels
FROM
  `banded-totality-398915.cars1.car_info`;

/* Query: What is the maximum value in the price column of the car_info table? */
SELECT
  MAX(price) AS max_price
FROM
  `banded-totality-398915.cars1.car_info`;

















