-- Some dummy data for testing purposes
USE transit_system;

INSERT INTO customers (email, username, fname, lname, pass)
VALUES
	('doe@rutgers.edu', 'johnnyboy', 'John', 'Doe', 'mypass'),
    ('jane@rutgers.edu', 'jane123', 'Jane', 'Smith', 'securepass'),
    ('alex@rutgers.edu', 'alexking', 'Alex', 'King', 'alexpass'),
    ('chris@rutgers.edu', 'chris', 'Chris', 'Johnson', 'chrispass');
    
INSERT INTO employees (essn, username, fname, lname, pass, role)
VALUES
    ('123-45-6789', 'empjohn', 'Michael', 'Scott', 'dundermifflin', 'custRep'),
    ('987-65-4321', 'empjane', 'Pam', 'Beesly', 'secureemp', 'custRep'),
    ('555-55-5555', 'empharry', 'Harry', 'Potter', 'gryffindor', 'custRep');
    
INSERT INTO stations (sid, states, cityName)
VALUES
    (1, 'New Jersey', 'Trenton'),
    (2, 'New York', 'New York'),
    (3, 'Pennsylvania', 'Philadelphia'),
    (4, 'Delaware', 'Wilmington'),
    (5, 'New Jersey', 'Princeton'),
    (6, 'New York', 'Brooklyn'),
    (7, 'Connecticut', 'Stamford'),
    (8, 'Massachusetts', 'Boston'),
    (9, 'Virginia', 'Richmond'),
    (10, 'Maryland', 'Baltimore'),
    (11, 'New Jersey', 'Newark'),
    (12, 'Connecticut', 'New Haven'),
    (13, 'Massachusetts', 'Cambridge'),
    (14, 'Pennsylvania', 'Pittsburgh'),
    (15, 'Delaware', 'Dover');
    
INSERT INTO trains (tid)
VALUES
    (101),
    (102),
    (103),
    (104),
    (105),
    (106),
    (107),
    (108),
    (109),
    (110);
    
INSERT INTO transitlines (lineName, fare, numStops, travelTime, origin, destination)
VALUES
    ('Route 1', 50.00, 5, 120, 1, 2),
    ('Route 2', 60.00, 6, 150, 2, 3),
    ('Route 3', 40.00, 4, 90, 3, 4),
    ('Route 4', 55.00, 5, 110, 4, 5),
    ('Route 5', 65.00, 7, 180, 5, 6),
    ('Route 6', 55.00, 6, 130, 6, 7),
    ('Route 7', 70.00, 6, 140, 7, 8),
    ('Route 8', 80.00, 8, 200, 8, 9),
    ('Route 9', 45.00, 5, 110, 9, 10),
    ('Route 10', 75.00, 7, 160, 10, 11);
    
INSERT INTO schedules (scheduleID, lineName, startStation, endStation, tid, departureTime, arrivalTime)
VALUES
    (1, 'Route 1', 1, 2, 101, '2024-01-01 08:00:00', '2024-01-01 10:00:00'),
    (2, 'Route 1', 2, 3, 102, '2024-01-01 10:30:00', '2024-01-01 12:30:00'),
    (3, 'Route 2', 2, 3, 103, '2024-01-01 09:00:00', '2024-01-01 11:30:00'),
    (4, 'Route 2', 3, 4, 104, '2024-01-01 12:00:00', '2024-01-01 14:30:00'),
    (5, 'Route 3', 3, 4, 105, '2024-01-01 08:30:00', '2024-01-01 10:00:00'),
    (6, 'Route 3', 4, 5, 106, '2024-01-01 09:30:00', '2024-01-01 11:00:00'),
    (7, 'Route 4', 4, 5, 107, '2024-01-01 07:30:00', '2024-01-01 09:00:00'),
    (8, 'Route 4', 5, 6, 108, '2024-01-01 10:00:00', '2024-01-01 12:00:00'),
    (9, 'Route 5', 5, 6, 109, '2024-01-01 08:00:00', '2024-01-01 10:00:00'),
    (10, 'Route 5', 6, 7, 110, '2024-01-01 09:30:00', '2024-01-01 11:30:00'),
    (11, 'Route 6', 6, 7, 101, '2024-01-02 08:00:00', '2024-01-02 10:00:00'),
    (12, 'Route 6', 7, 8, 102, '2024-01-02 10:30:00', '2024-01-02 12:30:00'),
    (13, 'Route 7', 7, 8, 103, '2024-01-02 09:00:00', '2024-01-02 11:00:00'),
    (14, 'Route 7', 8, 9, 104, '2024-01-02 11:30:00', '2024-01-02 13:30:00'),
    (15, 'Route 8', 8, 9, 105, '2024-01-02 08:00:00', '2024-01-02 10:30:00'),
    (16, 'Route 8', 9, 10, 106, '2024-01-02 10:00:00', '2024-01-02 12:00:00'),
    (17, 'Route 9', 9, 10, 107, '2024-01-02 08:30:00', '2024-01-02 10:00:00'),
    (18, 'Route 9', 10, 11, 108, '2024-01-02 09:00:00', '2024-01-02 11:00:00'),
    (19, 'Route 10', 10, 11, 109, '2024-01-02 08:00:00', '2024-01-02 10:30:00'),
    (20, 'Route 10', 11, 12, 110, '2024-01-02 09:30:00', '2024-01-02 11:30:00'),
	(21, 'Route 1', 1, 2, 101, '2024-02-01 06:00:00', '2024-02-01 08:00:00'),
    (22, 'Route 2', 2, 3, 103, '2024-02-01 09:00:00', '2024-02-01 11:00:00'),
    (23, 'Route 3', 3, 4, 105, '2024-02-02 12:30:00', '2024-02-02 14:00:00'),
    (24, 'Route 4', 4, 5, 108, '2024-03-01 10:30:00', '2024-03-01 12:00:00'),
    (25, 'Route 5', 5, 6, 109, '2024-03-02 07:30:00', '2024-03-02 09:30:00'),
    (26, 'Route 6', 6, 7, 102, '2024-03-03 09:30:00', '2024-03-03 11:30:00'),
    (27, 'Route 7', 7, 8, 110, '2024-03-03 14:00:00', '2024-03-03 16:30:00'),
    (28, 'Route 8', 8, 9, 107, '2024-04-01 15:30:00', '2024-04-01 18:00:00'),
    (29, 'Route 9', 9, 10, 105, '2024-04-02 08:00:00', '2024-04-02 10:00:00'),
    (30, 'Route 10', 10, 11, 104, '2024-04-02 11:00:00', '2024-04-02 13:30:00');
 	
INSERT INTO reservationHas (rnumber, date, totalFare, transitLine, passenger, email)
VALUES
    (1, '2024-01-01 07:30:00', 50.00, 'Route 1', 'John Doe', 'doe@rutgers.edu'),
    (2, '2024-01-01 09:00:00', 60.00, 'Route 2', 'Jane Smith', 'jane@rutgers.edu'),
    (3, '2024-01-01 11:30:00', 40.00, 'Route 3', 'Alex King', 'alex@rutgers.edu'),
    (4, '2024-01-01 12:30:00', 55.00, 'Route 4', 'Chris Johnson', 'chris@rutgers.edu'),
    (5, '2024-01-01 08:00:00', 65.00, 'Route 5', 'John Doe', 'doe@rutgers.edu'),
    (6, '2024-01-01 10:30:00', 55.00, 'Route 6', 'Jane Smith', 'jane@rutgers.edu'),
    (7, '2024-01-01 12:00:00', 70.00, 'Route 7', 'Alex King', 'alex@rutgers.edu'),
    (8, '2024-01-01 09:30:00', 80.00, 'Route 8', 'Chris Johnson', 'chris@rutgers.edu'),
    (9, '2024-01-02 08:00:00', 45.00, 'Route 9', 'John Doe', 'doe@rutgers.edu'),
    (10, '2024-01-02 10:30:00', 75.00, 'Route 10', 'Jane Smith', 'jane@rutgers.edu'),
    (11, '2024-01-02 08:30:00', 50.00, 'Route 1', 'Alex King', 'alex@rutgers.edu'),
    (12, '2024-01-02 09:00:00', 60.00, 'Route 2', 'Chris Johnson', 'chris@rutgers.edu'),
    (13, '2024-01-02 11:00:00', 40.00, 'Route 3', 'John Doe', 'doe@rutgers.edu'),
    (14, '2024-01-02 01:00:00', 55.00, 'Route 4', 'Jane Smith', 'jane@rutgers.edu'),
    (15, '2024-01-02 07:30:00', 65.00, 'Route 5', 'Alex King', 'alex@rutgers.edu'),
    (16, '2024-01-02 09:15:00', 55.00, 'Route 6', 'Chris Johnson', 'chris@rutgers.edu'),
    (17, '2024-01-02 10:00:00', 70.00, 'Route 7', 'John Doe', 'doe@rutgers.edu'),
    (18, '2024-01-02 08:30:00', 80.00, 'Route 8', 'Jane Smith', 'jane@rutgers.edu'),
    (19, '2024-01-02 09:00:00', 45.00, 'Route 9', 'Alex King', 'alex@rutgers.edu'),
    (20, '2024-01-02 10:00:00', 75.00, 'Route 10', 'Chris Johnson', 'chris@rutgers.edu');