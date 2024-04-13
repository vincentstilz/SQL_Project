-- First, create a table for the dataset:

CREATE TABLE medical_data (
Age INT,
Gender INT,
Heart_Rate INT,
Systolic_blood_pressure INT,
	Dialostic_blood_pressure INT,
	Blood_sugar NUMERIC (5,2),
	CK_MB DECIMAL (5,2),
	Troponin DECIMAL (5,2),
	Result VARCHAR (15)	
);

-- Check that uploading of the dataset has worked.
SELECT * from medical_data


-- Count the number of positive and negative heart attack diagnoses
SELECT result, COUNT(*) AS count
FROM medical_data
GROUP BY result;

--positive diagnosis: 810, negative diagnoses: 509


-- Calculate the average of various health metrics grouped by the heart attack diagnosis result
SELECT result, 
       AVG(age) AS average_age, -- Average age
       AVG(heart_rate) AS average_heart_rate, -- Average heart rate
       AVG(systolic_blood_pressure) AS average_systolic_bp, -- Average systolic blood pressure
       AVG(diastolic_blood_pressure) AS average_diastolic_bp, -- Average diastolic blood pressure
       AVG(blood_sugar) AS average_blood_sugar, -- Average blood sugar level
       AVG(ck_mb) AS average_ck_mb, -- Average CK-MB enzyme level
       AVG(troponin) AS average_troponin -- Average troponin level
FROM medical_data
GROUP BY result;


--	Negative Diagnosis: Average age ~52.1, heart rate ~77.89, systolic BP ~127.86, diastolic BP ~72.44, blood sugar ~149.76, CK_MB ~2.55, troponin ~0.027.
--	Positive Diagnosis: Average age ~58.76, heart rate ~78.62, systolic BP ~126.74, diastolic BP ~72.16, blood sugar ~144.67, CK_MB ~23.27, troponin ~0.571.


--AGE

-- Analyze the overall age distribution of patients in the dataset
SELECT AVG(age) AS average_age, -- Average age of patients
       MIN(age) AS min_age, -- Minimum age of patients
       MAX(age) AS max_age -- Maximum age of patients
FROM medical_data;

-- Calculate the average age of patients grouped by their heart attack diagnosis result SELECT result, AVG(age) AS average_age 
FROM medical_data 
GROUP BY result; 

--Negative average age 52,1; positive average age 58,76 years

--GENDER

-- Analyze the gender distribution of patients in the dataset
SELECT gender, COUNT(*) AS count
FROM medical_data
GROUP BY gender;

-- Count the number of patients by gender for each diagnosis result
SELECT result, gender, COUNT(*) AS count
FROM medical_data
GROUP BY result, gender;

--Females: 202 negative results, 247 positive results
--Males: 307 negative results, 563 positive results


--BLOOD SUGAR

-- Analyze blood sugar levels in patients with a positive heart attack diagnosis
SELECT AVG(blood_sugar) AS average_blood_sugar, MIN(blood_sugar) AS min_blood_sugar, MAX(blood_sugar) AS max_blood_sugar
FROM medical_data
WHERE result = 'positive';

--Average blood sugar: 144,67; min 35,00 max blood sugar 541




--CK-MB Troponin levels
-- Compare average troponin and CK-MB levels in positive and negative heart attack diagnoses
SELECT result, AVG(troponin) AS average_troponin, AVG(ck_mb) AS average_ck_mb
FROM medical_data
GROUP BY result;


-- Analysis of heart attack diagnoses based on troponin threshold
SELECT troponin > 0.1 AS troponin_high_risk, result, COUNT(*) AS count
FROM medical_data
GROUP BY troponin_high_risk, result;

--When exceeding the troponin threshold of 0,1, only 2 results were negative and 303 positive



-- Analysis of heart attack diagnoses based on CK-MB threshold
SELECT ck_mb > 5 AS ck_mb_high_risk, result, COUNT(*) AS count
FROM medical_data
GROUP BY ck_mb_high_risk, result;

--When exceeding the CK-MB threshold of 5, only 29 results were negative and 350 positive
