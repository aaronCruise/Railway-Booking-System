DROP DATABASE Transit_System;
CREATE DATABASE Transit_System;
USE Transit_System;
CREATE TABLE customers
(
    email VARCHAR(30) PRIMARY KEY,
    username VARCHAR(20),
    fname VARCHAR(20),
    lname VARCHAR(20),
    pass VARCHAR(20)
);

CREATE TABLE employees
(
    essn VARCHAR(11) PRIMARY KEY,
    username VARCHAR(20),
    fname VARCHAR(20),
    lname VARCHAR(20),
    pass VARCHAR(20)
);

CREATE TABLE transitlines
(
    lineName VARCHAR(50) PRIMARY KEY,
    fare FLOAT,
    numStops INTEGER,
    travelTime INTEGER
);

CREATE TABLE reservationHas
(
    rnumber INTEGER PRIMARY KEY,
    date DATETIME,
    totalFare FLOAT,
    transitLine VARCHAR(50),
    passenger VARCHAR(30),
    email VARCHAR(30),
    FOREIGN KEY (transitLine) REFERENCES transitlines(lineName),
    FOREIGN KEY(email) REFERENCES customers(email)
);

CREATE TABLE oversees
(
    email VARCHAR(30) PRIMARY KEY,
    rnumber INTEGER,
    FOREIGN KEY (email) REFERENCES customers(email),
    FOREIGN KEY (rnumber) REFERENCES reservationHas(rnumber)
);

CREATE TABLE trains
(
    tid int PRIMARY KEY
);

CREATE TABLE stations
(
    sid INTEGER PRIMARY KEY,
    states VARCHAR(50),
    cityName VARCHAR(50)
);

CREATE TABLE schedules
(
    lineName VARCHAR(50) PRIMARY KEY,
    sid INTEGER,
    tid INTEGER,
    FOREIGN KEY(lineName) REFERENCES transitlines(lineName),
    FOREIGN KEY(sid) REFERENCES stations(sid),
    FOREIGN KEY(tid) REFERENCES trains(tid)
);

CREATE TABLE origin
(
    lineName VARCHAR(50),
    sid INTEGER PRIMARY KEY,
    FOREIGN KEY (lineName) REFERENCES transitlines(lineName),
    FOREIGN KEY (sid) REFERENCES stations(sid)
);

CREATE TABLE destination
(
    lineName VARCHAR(50),
    sid INTEGER PRIMARY KEY,
    FOREIGN KEY(lineName) REFERENCES transitlines(lineName),
    FOREIGN KEY (sid) REFERENCES stations(sid)
);


INSERT INTO customers
VALUES
    (
        "doe@rutgers.edu", "johnnyboy", "John", "Doe", "mypass");

