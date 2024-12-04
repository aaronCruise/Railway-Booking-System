use transit_system;
show tables;

INSERT INTO transitlines
VALUES
    ('Route 1', 2.5, 10, 30),
    ('Route 2', 3.0, 12, 40),
    ('Route 3', 1.5, 8, 20),
    ('ny', 2, 9, 32);
    
INSERT INTO customers
VALUES
-- 	('doe@rutgers.edu', 'johnnyboy', 'John', 'Doe', 'mypass'),
    ('jane@rutgers.edu', 'jane123', 'Jane', 'Smith', 'securepass'),
    ('alex@rutgers.edu', 'alexking', 'Alex', 'King', 'alexpass'),
    ('chris@rutgers.edu', 'chris', 'Chris', 'Johnson', 'chrispass');
    
INSERT INTO employees
VALUES
    ('123-45-6789', 'empjohn', 'Michael', 'Scott', 'dundermifflin'),
    ('987-65-4321', 'empjane', 'Pam', 'Beesly', 'secureemp'),
    ('555-55-5555', 'empharry', 'Harry', 'Potter', 'gryffindor');

insert into reservationHas values (1, '2024-01-15 10:30:00', 50.75, 'ny', 'John', 'doe@rutgers.edu'),
(2, '2024-02-20 14:45:00', 75.00,'ny', 'John', 'doe@rutgers.edu'),
(3, '2024-03-10 09:00:00', 60.25,'ny',  'John', 'doe@rutgers.edu'),
(4, '2024-01-25 16:15:00', 85.50,'ny',  'John', 'doe@rutgers.edu'),
(5, '2024-02-05 12:00:00', 90.00,'ny',  'John', 'doe@rutgers.edu'),
(6, '2024-03-15 20:00:00', 45.00,'ny', 'John', 'doe@rutgers.edu'),
(7, '2024-04-10 10:00:00', 30.50, 'Route 1', 'Jane', 'jane@rutgers.edu'),
(8, '2024-05-12 11:30:00', 40.75, 'Route 2', 'Jane', 'jane@rutgers.edu'),
(9, '2024-06-15 09:45:00', 35.00, 'Route 3', 'Jane', 'jane@rutgers.edu'),
(10, '2024-04-20 13:20:00', 65.25, 'Route 1', 'Jane', 'jane@rutgers.edu'),
(11, '2024-05-25 14:50:00', 50.00, 'Route 2', 'Jane', 'jane@rutgers.edu'),
(12, '2024-06-30 16:40:00', 55.00, 'Route 3', 'Jane', 'jane@rutgers.edu'),
(13, '2024-07-05 10:10:00', 25.00, 'Route 1', 'Alex', 'alex@rutgers.edu'),
(14, '2024-07-15 18:30:00', 40.00, 'Route 2', 'Alex', 'alex@rutgers.edu'),
(15, '2024-08-01 20:00:00', 35.50, 'Route 3', 'Alex', 'alex@rutgers.edu'),
(16, '2024-07-10 12:45:00', 70.00, 'Route 1', 'Alex', 'alex@rutgers.edu'),
(17, '2024-08-20 14:00:00', 80.50, 'Route 2', 'Alex', 'alex@rutgers.edu'),
(18, '2024-09-15 08:30:00', 90.00, 'Route 3', 'Alex', 'alex@rutgers.edu'),
(19, '2024-03-22 10:00:00', 25.75, 'Route 1', 'Chris', 'chris@rutgers.edu'),
(20, '2024-04-02 15:30:00', 55.00, 'Route 2', 'Chris', 'chris@rutgers.edu'),
(21, '2024-05-12 17:20:00', 60.25, 'Route 3', 'Chris', 'chris@rutgers.edu'),
(22, '2024-03-15 14:50:00', 45.50, 'Route 1', 'Chris', 'chris@rutgers.edu'),
(23, '2024-04-20 11:30:00', 85.00, 'Route 2', 'Chris', 'chris@rutgers.edu'),
(24, '2024-05-25 12:15:00', 95.50, 'Route 3', 'Chris', 'chris@rutgers.edu'),
(25, '2024-01-10 09:00:00', 50.00, 'Route 1', 'John', 'doe@rutgers.edu'),
(26, '2024-02-14 13:45:00', 75.00, 'Route 1', 'John', 'doe@rutgers.edu'),
(27, '2024-03-20 16:15:00', 100.00, 'Route 1', 'John', 'doe@rutgers.edu'),
(28, '2024-01-18 10:30:00', 50.75, 'Route 2', 'Jane', 'jane@rutgers.edu'),
(29, '2024-02-22 14:45:00', 75.00, 'Route 2', 'Jane', 'jane@rutgers.edu'),
(30, '2024-03-18 09:00:00', 60.25, 'Route 2', 'Jane', 'jane@rutgers.edu');