-- Creating the tables
CREATE TABLE UserProfiles (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    user_bio VARCHAR(MAX)
);

CREATE TABLE UserMessages (
    message_id INT PRIMARY KEY IDENTITY(1,1),
    sender_id INT,
    receiver_id INT,
    message_content VARCHAR(MAX) NOT NULL,
    timestamp DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (sender_id) REFERENCES UserProfiles(user_id),
    FOREIGN KEY (receiver_id) REFERENCES UserProfiles(user_id)
);

CREATE TABLE Services (
    service_id INT PRIMARY KEY IDENTITY(1,1),
    service_name VARCHAR(50) NOT NULL,
    description VARCHAR(MAX),
    price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE UserServices (
    user_service_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    service_id INT,
    purchase_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES UserProfiles(user_id),
    FOREIGN KEY (service_id) REFERENCES Services(service_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    service_id INT,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES UserProfiles(user_id),
    FOREIGN KEY (service_id) REFERENCES Services(service_id)
);

-- Inserting records
INSERT INTO UserProfiles (username, email, password, user_bio) VALUES
('user1', 'user1@example.com', 'password1', 'Profile info 1'),
('user2', 'user2@example.com', 'password2', 'Profile info 2'),
('user3', 'user3@example.com', 'password3', 'Profile info 3'),
('user4', 'user4@example.com', 'password4', 'Profile info 4'),
('user5', 'user5@example.com', 'password5', 'Profile info 5'),
('user6', 'user6@example.com', 'password6', 'Profile info 6');

INSERT INTO UserMessages (sender_id, receiver_id, message_content) VALUES
(1, 2, 'Hello from user1 to user2'),
(2, 3, 'Hello from user2 to user3'),
(3, 4, 'Hello from user3 to user4'),
(4, 5, 'Hello from user4 to user5'),
(5, 6, 'Hello from user5 to user6'),
(6, 1, 'Hello from user6 to user1');

INSERT INTO Services (service_name, description, price) VALUES
('Service1', 'Description for service 1', 9.99),
('Service2', 'Description for service 2', 19.99),
('Service3', 'Description for service 3', 29.99),
('Service4', 'Description for service 4', 39.99),
('Service5', 'Description for service 5', 49.99),
('Service6', 'Description for service 6', 59.99);

INSERT INTO UserServices (user_id, service_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6);

INSERT INTO Payments (user_id, service_id, amount) VALUES
(1, 1, 9.99),
(2, 2, 19.99),
(3, 3, 29.99),
(4, 4, 39.99),
(5, 5, 49.99),
(6, 6, 59.99);

-- Updating records
UPDATE UserProfiles SET user_bio = 'Updated Profile info 1' WHERE user_id = 1;
UPDATE UserProfiles SET user_bio = 'Updated Profile info 2' WHERE user_id = 2;

UPDATE UserMessages SET message_content = 'Updated message from user1 to user2' WHERE message_id = 1;
UPDATE UserMessages SET message_content = 'Updated message from user2 to user3' WHERE message_id = 2;

UPDATE Services SET price = 11.99 WHERE service_id = 1;
UPDATE Services SET price = 21.99 WHERE service_id = 2;

UPDATE UserServices SET purchase_date = '2024-07-08 12:00:00' WHERE user_service_id = 1;
UPDATE UserServices SET purchase_date = '2024-07-08 13:00:00' WHERE user_service_id = 2;

UPDATE Payments SET amount = 11.99 WHERE payment_id = 1;
UPDATE Payments SET amount = 21.99 WHERE payment_id = 2;

-- Deleting records
DELETE FROM UserProfiles WHERE user_id = 5;
DELETE FROM UserProfiles WHERE user_id = 6;

DELETE FROM UserMessages WHERE message_id = 5;
DELETE FROM UserMessages WHERE message_id = 6;

DELETE FROM Services WHERE service_id = 5;
DELETE FROM Services WHERE service_id = 6;

DELETE FROM UserServices WHERE user_service_id = 5;
DELETE FROM UserServices WHERE user_service_id = 6;

DELETE FROM Payments WHERE payment_id = 5;
DELETE FROM Payments WHERE payment_id = 6;

-- Modifying table names
EXEC sp_rename 'UserProfiles', 'Users';
EXEC sp_rename 'UserMessages', 'Messages';

-- Modifying columns
ALTER TABLE Users ADD bio VARCHAR(MAX);
ALTER TABLE Users DROP COLUMN user_bio;

ALTER TABLE Services ADD service_desc VARCHAR(MAX);
ALTER TABLE Services DROP COLUMN description;
