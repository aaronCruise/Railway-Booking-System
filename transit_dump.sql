DROP DATABASE IF EXISTS Transit_System;
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
    pass VARCHAR(20),
    role VARCHAR(20)
);

CREATE TABLE trains
(
    tid INT PRIMARY KEY
);

CREATE TABLE stations
(
    sid INTEGER PRIMARY KEY,
    states VARCHAR(50),
    cityName VARCHAR(50)
);

CREATE TABLE transitlines
(
    lineName VARCHAR(50) PRIMARY KEY,
    fare FLOAT,
    numStops INTEGER,
    travelTime INTEGER,
    origin INTEGER,
    destination INTEGER,
    FOREIGN KEY (origin) REFERENCES stations(sid),
    FOREIGN KEY (destination) REFERENCES stations(sid)
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

CREATE TABLE schedules
(
    scheduleID INTEGER PRIMARY KEY,
    lineName VARCHAR(50),
    -- the transit line that this schedule is part of
    startStation INTEGER,
    -- origin station for the schedule. can be any of the stops within the transit line
    endStation INTEGER,
    -- destination station for the schedule. "
    tid INTEGER,
    -- train assigned to this schedule
    departureTime DATETIME,
    -- for startStation
    arrivalTime DATETIME,
    -- for endStation
    FOREIGN KEY(lineName) REFERENCES transitlines(lineName),
    FOREIGN KEY(startStation) REFERENCES stations(sid),
    FOREIGN KEY(endStation) REFERENCES stations(sid),
    FOREIGN KEY(tid) REFERENCES trains(tid)
);


CREATE TABLE posts
(
    postID INTEGER PRIMARY KEY,
    question VARCHAR(256),
    answer VARCHAR(256),
    email VARCHAR(30),
    username VARCHAR(20) NULL,
    FOREIGN KEY(email) REFERENCES customers(email),
    FOREIGN KEY(username) REFERENCES employees(username)
);

-- Unnecessary tables as of now. Can be deleted if they're not used.
-- CREATE TABLE origin
-- (
--     lineName VARCHAR(50),
--     sid INTEGER PRIMARY KEY,
--     FOREIGN KEY (lineName) REFERENCES transitlines(lineName),
--     FOREIGN KEY (sid) REFERENCES stations(sid)
-- );

-- CREATE TABLE destination
-- (
--     lineName VARCHAR(50),
--     sid INTEGER PRIMARY KEY,
--     FOREIGN KEY(lineName) REFERENCES transitlines(lineName),
--     FOREIGN KEY (sid) REFERENCES stations(sid)
-- );

-- CREATE TABLE oversees
-- (
--     email VARCHAR(30) PRIMARY KEY,
--     rnumber INTEGER,
--     FOREIGN KEY (email) REFERENCES customers(email),
--     FOREIGN KEY (rnumber) REFERENCES reservationHas(rnumber)
-- );

-- Initial credentials for testing
INSERT INTO employees
VALUES
    ("1", "admin", "John", "Doe", "mypass", "admin"),
    ("2", "CustRep", "Jane", "Doe", "mypass", "CustRep");

INSERT INTO customers
    (email, username, pass)
VALUES
    ("email@domain.com", "user", "pass");
