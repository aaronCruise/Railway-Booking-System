CREATE DATABASE Transit_System;
USE Transit_System;
CREATE TABLE customers(
email char(50) PRIMARY KEY,
username char(50),
fname char(50),
lname char(50),
pass char(50)
);

CREATE TABLE employees(
username char(50) PRIMARY KEY,
SSN char(9),
fname char(50),
lname char(50),
pass char(50)
);

INSERT INTO customers VALUES (
"doe@rutgers.edu", "johnnyboy", "John", "Doe", "mypass");

