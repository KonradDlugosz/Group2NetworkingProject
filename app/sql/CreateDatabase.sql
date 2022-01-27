DROP DATABASE IF EXISTS `finalweekdb`;
CREATE DATABASE `finalweekdb`;

USE `finalweekdb`;

CREATE TABLE users
(
    userId INT NOT NULL AUTO_INCREMENT,
    firstname varchar(160) NOT NULL,
    lastname varchar(160) NOT NULL,
    username varchar(160) NOT NULL,
    `password` varchar(160) NOT NULL,
	token varchar(160) NOT NULL,
    PRIMARY KEY  (`userId`)
);

CREATE TABLE items
(
    id INT NOT NULL AUTO_INCREMENT,
    userId INT NOT NULL,
    item varchar(160) NOT NULL,
    PRIMARY KEY  (id),
    FOREIGN KEY (userId) REFERENCES users(userId)
);

INSERT INTO Users VALUES(1, 'root', 'root', 'rootaccount', '$10$xVp6ahZxN71CRZcZ4mpUxeMp5QZ6ZPpGuXcZ/1d7xgAUjDWr0.vFG' , 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJrb25yYWQyMjIwIn0.WZiR-67FY1299ipKhgLFTbwTy9J7NhyXcWEmdGPQbFY');

