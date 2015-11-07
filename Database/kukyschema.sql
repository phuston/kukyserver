DROP TABLE IF EXISTS Ku_user;
DROP TABLE IF EXISTS Ku_comment_user;
DROP TABLE IF EXISTS Kus;
DROP TABLE IF EXISTS Comments;
DROP TABLE IF EXISTS Users;

CREATE TABLE Kus (
	ID int NOT NULL AUTO_INCREMENT,
	Content varchar(255) NOT NULL,
	Upvotes int NOT NULL,
	Downvotes int NOT NULL, 
	Time timestamp NOT NULL,
	Lat float NOT NULL,
	Lon float NOT NULL,
	PRIMARY KEY (ID)
);

CREATE TABLE Comments (
	ID int NOT NULL AUTO_INCREMENT,
	Content varchar(255) NOT NULL,
	Upvotes int NOT NULL,
	Downvotes int NOT NULL,
	PRIMARY KEY (ID)
);

CREATE TABLE Users (
	ID int NOT NULL AUTO_INCREMENT,
	Username varchar(20) NOT NULL,
	Score int NOT NULL,
	PRIMARY KEY (ID)
);

CREATE TABLE Ku_comment_user (
	User_id int,
	Comment_id int,
	Ku_id int,
	FOREIGN KEY (User_id) REFERENCES Users(ID),
	FOREIGN KEY (Comment_id) REFERENCES Comments(ID),
	FOREIGN KEY (Ku_id) REFERENCES Kus(ID)
);

CREATE TABLE Ku_user (
	User_id int,
	Ku_id int,
	Is_favorite boolean,
	FOREIGN KEY (User_id) REFERENCES Users(ID),
	FOREIGN KEY (Ku_id) REFERENCES Kus(ID)
);
