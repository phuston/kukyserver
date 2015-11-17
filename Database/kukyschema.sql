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
	Lat float NOT NULL,
	Lon float NOT NULL,
    createdAt timestamp NOT NULL,
    updatedAt timestamp NOT NULL,
	PRIMARY KEY (ID)
);

CREATE TABLE Comments (
	ID int NOT NULL AUTO_INCREMENT,
	Content varchar(255) NOT NULL,
	Upvotes int NOT NULL,
	Downvotes int NOT NULL,
    createdAt timestamp NOT NULL,
    updatedAt timestamp NOT NULL,
	PRIMARY KEY (ID)
);

CREATE TABLE Users (
	ID int NOT NULL AUTO_INCREMENT,
	Username varchar(20) NOT NULL,
	Score int NOT NULL,
    createdAt timestamp NOT NULL,
    updatedAt timestamp NOT NULL,
	PRIMARY KEY (ID)
);

CREATE TABLE Ku_comment_users (
	User_id int,
	Comment_id int,
	Ku_id int,
	FOREIGN KEY (User_id) REFERENCES Users(ID),
	FOREIGN KEY (Comment_id) REFERENCES Comments(ID),
	FOREIGN KEY (Ku_id) REFERENCES Kus(ID),
    createdAt timestamp NOT NULL,
    updatedAt timestamp NOT NULL
);

CREATE TABLE Ku_users (
	User_id int,
	Ku_id int,
	Is_favorite boolean,
	FOREIGN KEY (User_id) REFERENCES Users(ID),
	FOREIGN KEY (Ku_id) REFERENCES Kus(ID),
    createdAt timestamp NOT NULL,
    updatedAt timestamp NOT NULL
);

INSERT INTO Users(Username, Score, createdAt, updatedAt) VALUES ('Patrick', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Users(Username, Score, createdAt, updatedAt) VALUES ('Keenan', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Users(Username, Score, createdAt, updatedAt) VALUES ('Hieu', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Users(Username, Score, createdAt, updatedAt) VALUES ('Franton', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Users(Username, Score, createdAt, updatedAt) VALUES ('Bitch', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Users(Username, Score, createdAt, updatedAt) VALUES ('Peter', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Kus(Content, Upvotes, Downvotes, Lat, Lon, createdAt, updatedAt) VALUES ("hello there patrick;this is a test oh boy yes;slowly passing gas", 0, 0, 42.1, -71.34, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_users VALUES (1, LAST_INSERT_ID(), 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Kus(Content, Upvotes, Downvotes, Lat, Lon, createdAt, updatedAt) VALUES ("an old silent pond;a frog jumps into the pond;SPLASH - silence again", 0, 0, 42.1, -71.34, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_users VALUES (2, LAST_INSERT_ID(), 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Kus(Content, Upvotes, Downvotes, Lat, Lon, createdAt, updatedAt) VALUES ("alone in the rain;damp ones on my hairy legs;slowly passing gas", 0, 0, 42.1, -71.34, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_users VALUES (3, LAST_INSERT_ID(), 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Kus(Content, Upvotes, Downvotes, Lat, Lon, createdAt, updatedAt) VALUES ("I wake, reluctant;too cold to get out of bed;but I need to pee", 0, 0, 42.1, -71.34, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_users VALUES (4, LAST_INSERT_ID(), 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Kus(Content, Upvotes, Downvotes, Lat, Lon, createdAt, updatedAt) VALUES ("Haikus are easy;But sometimes they don't make sense;Refrigerator", 0, 0, 42.1, -71.34, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_users VALUES (5, LAST_INSERT_ID(), 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Kus(Content, Upvotes, Downvotes, Lat, Lon, createdAt, updatedAt) VALUES ("Space is limited;In a haiku so it's hard;to finish what you", 0, 0, 42.1, -71.34, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_users VALUES (6, LAST_INSERT_ID(), 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Kus(Content, Upvotes, Downvotes, Lat, Lon, createdAt, updatedAt) VALUES ("Hippopotamus;Anti-hippopotamus;Annihilation", 0, 0, 42.1, -71.34, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_users VALUES (2, LAST_INSERT_ID(), 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Kus(Content, Upvotes, Downvotes, Lat, Lon, createdAt, updatedAt) VALUES ("Expand your mind. Get;to work. Better yet, put your;feet up. Watch tv.", 0, 0, 42.1, -71.34, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_users VALUES (3, LAST_INSERT_ID(), 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Kus(Content, Upvotes, Downvotes, Lat, Lon, createdAt, updatedAt) VALUES ("Testicles are fun;Unless you get kicked in them;That fucking sucks balls", 0, 0, 42.1, -71.34, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_users VALUES (5, LAST_INSERT_ID(), 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Kus(Content, Upvotes, Downvotes, Lat, Lon, createdAt, updatedAt) VALUES ("How many lightbulbs;Does it take to screw a shrink;Oh, got it backwards", 0, 0, 42.1, -71.34, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_users VALUES (1, LAST_INSERT_ID(), 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Kus(Content, Upvotes, Downvotes, Lat, Lon, createdAt, updatedAt) VALUES ("fuck shit goddamnit;motherfucking shit ow ow;fuck shit fuck fuck fuck", 0, 0, 42.1, -71.34, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_users VALUES (4, LAST_INSERT_ID(), 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('I love you', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (5, LAST_INSERT_ID(), 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('This is okay', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (3, LAST_INSERT_ID(), 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('This is a test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (2, LAST_INSERT_ID(), 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('This is another test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (3, LAST_INSERT_ID(), 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('this shit sucks', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (5, LAST_INSERT_ID(), 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('check me', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (4, LAST_INSERT_ID(), 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('I love you', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (1, LAST_INSERT_ID(), 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('This is a test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (6, LAST_INSERT_ID(), 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('u fokken wot m8', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (5, LAST_INSERT_ID(), 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('this shit sucks', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (3, LAST_INSERT_ID(), 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('This is another test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (2, LAST_INSERT_ID(), 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('I blue myself', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (6, LAST_INSERT_ID(), 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('this shit sucks', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (1, LAST_INSERT_ID(), 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('check me', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (6, LAST_INSERT_ID(), 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('check me', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (4, LAST_INSERT_ID(), 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('This is okay', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (5, LAST_INSERT_ID(), 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('I love you', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (5, LAST_INSERT_ID(), 6, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('ur so clevar', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (6, LAST_INSERT_ID(), 6, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('this shit sucks', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (5, LAST_INSERT_ID(), 7, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('I love you', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (5, LAST_INSERT_ID(), 8, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('marry me', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (1, LAST_INSERT_ID(), 8, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('this shit sucks', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (5, LAST_INSERT_ID(), 9, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('check me', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (3, LAST_INSERT_ID(), 9, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('I love you', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (1, LAST_INSERT_ID(), 9, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('this is the last test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (4, LAST_INSERT_ID(), 9, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('This is a test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (1, LAST_INSERT_ID(), 9, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('This is okay', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (1, LAST_INSERT_ID(), 10, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('check me', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (4, LAST_INSERT_ID(), 10, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('This is a test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (3, LAST_INSERT_ID(), 10, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('this is the last test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (4, LAST_INSERT_ID(), 10, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('This is another test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (4, LAST_INSERT_ID(), 10, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('This is okay', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (1, LAST_INSERT_ID(), 11, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('check me', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (2, LAST_INSERT_ID(), 11, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('I love you', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (2, LAST_INSERT_ID(), 11, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('I blue myself', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (2, LAST_INSERT_ID(), 11, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(Content, Upvotes, Downvotes, createdAt, updatedAt) VALUES ('This is a test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users VALUES (4, LAST_INSERT_ID(), 11, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

