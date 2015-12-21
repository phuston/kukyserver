DROP TABLE IF EXISTS Ku_users;
DROP TABLE IF EXISTS Ku_comment_users;
DROP TABLE IF EXISTS Kus;
DROP TABLE IF EXISTS User_auths;
DROP TABLE IF EXISTS Comments;
DROP TABLE IF EXISTS Users;

-- Making table paranoid. Add karma field. Make username primarykey.
-- Login: take uname and pw, return new api key.
-- Anytime someone sends any request, double check username and api key (Franton).

CREATE TABLE Kus (
	id int NOT NULL AUTO_INCREMENT,
	content varchar(255) NOT NULL,
	upvotes int NOT NULL,
	downvotes int NOT NULL,
    karma int NOT NULL, 
	lat float NOT NULL,
	lon float NOT NULL,
    createdAt timestamp NOT NULL,
    updatedAt timestamp NOT NULL,
    deletedAt timestamp,
	PRIMARY KEY (id)
);

CREATE TABLE Comments (
	id int NOT NULL AUTO_INCREMENT,
	content varchar(255) NOT NULL,
	upvotes int NOT NULL,
	downvotes int NOT NULL,
    createdAt timestamp NOT NULL,
    updatedAt timestamp NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE Users (
	id int NOT NULL AUTO_INCREMENT,
	username varchar(30) NOT NULL,
	score int NOT NULL,
    radiusLimit float,
    createdAt timestamp NOT NULL,
    updatedAt timestamp NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE Ku_comment_users (
    id int NOT NULL AUTO_INCREMENT,
	userId int NOT NULL,
	commentId int NOT NULL,
	kuId int NOT NULL,
    relationship int NOT NULL, -- 0: nothing, 1: OP, 2: upvoted, 3: downvoted
	FOREIGN KEY (userId) REFERENCES Users(id),
	FOREIGN KEY (commentId) REFERENCES Comments(id),
	FOREIGN KEY (kuId) REFERENCES Kus(id),
    PRIMARY KEY (id),
    createdAt timestamp NOT NULL,
    updatedAt timestamp NOT NULL
);

CREATE TABLE Ku_users (
    id int NOT NULL AUTO_INCREMENT,
	userId int NOT NULL,
	kuId int NOT NULL,
	relationship int NOT NULL, -- 0: composed, 1: favorited, 2: upvoted, 3: downvoted
	FOREIGN KEY (userId) REFERENCES Users(id),
	FOREIGN KEY (kuId) REFERENCES Kus(id),
    PRIMARY KEY (id),
    createdAt timestamp NOT NULL,
    updatedAt timestamp NOT NULL
);

CREATE TABLE User_auths (
    userId int NOT NULL,
    FOREIGN KEY (userId) REFERENCES Users(id),
    username varchar(30) NOT NULL,
	apiKey varchar(255) NOT NULL,
    hashedPassword varchar(255) NOT NULL,
    createdAt timestamp NOT NULL,
    updatedAt timestamp NOT NULl,
    PRIMARY KEY (username)
);

-- Create Users
INSERT INTO Users(Username, Score, radiusLimit, createdAt, updatedAt) VALUES ('patrick', 0, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO User_auths VALUES (LAST_INSERT_ID(), 'patrick', 'AIKzkIO91099ckLIK39cKEI', 'atrickpay', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Users(Username, Score, radiusLimit, createdAt, updatedAt) VALUES ('keenan', 0, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO User_auths VALUES (LAST_INSERT_ID(), 'keenan', '91029KJDxiILk81kKI01929', 'eenankay', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Users(Username, Score, radiusLimit, createdAt, updatedAt) VALUES ('hieu', 0, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO User_auths VALUES (LAST_INSERT_ID(), 'hieu', '18xcCMU120lKqPZ182zXX', 'ieuhay', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Users(Username, Score, radiusLimit, createdAt, updatedAt) VALUES ('franton', 0, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO User_auths VALUES (LAST_INSERT_ID(), 'franton', 'MEixck92lak9UsRI1291lXyz', 'rantonfay', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Users(Username, Score, radiusLimit, createdAt, updatedAt) VALUES ('bitch', 0, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO User_auths VALUES (LAST_INSERT_ID(), 'bitch', 'AIz917CdkllVZcT1l99cdAm', 'itchbay', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Users(Username, Score, radiusLimit, createdAt, updatedAt) VALUES ('peter', 0, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO User_auths VALUES (LAST_INSERT_ID(), 'peter', 'OVA959lRIsUVYmc8SyCyazIA', 'eterpay', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Create Kus
INSERT INTO Kus(content, upvotes, downvotes, lat, lon, createdAt, updatedAt) VALUES ("hello there patrick;this is a test oh boy yes;slowly passing gas", 0, 0, 42.1, -71.34, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_users(userId, kuId, relationship, createdAt, updatedAt) VALUES (1, LAST_INSERT_ID(), 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Kus(content, upvotes, downvotes, lat, lon, createdAt, updatedAt) VALUES ("an old silent pond;a frog jumps into the pond;SPLASH - silence again", 0, 0, 42.1, -71.34, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_users(userId, kuId, relationship, createdAt, updatedAt) VALUES (2, LAST_INSERT_ID(), 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Kus(content, upvotes, downvotes, lat, lon, createdAt, updatedAt) VALUES ("alone in the rain;damp ones on my hairy legs;slowly passing gas", 0, 0, 42.1, -71.34, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_users(userId, kuId, relationship, createdAt, updatedAt) VALUES (3, LAST_INSERT_ID(), 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Kus(content, upvotes, downvotes, lat, lon, createdAt, updatedAt) VALUES ("I wake, reluctant;too cold to get out of bed;but I need to pee", 0, 0, 42.1, -71.34, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_users(userId, kuId, relationship, createdAt, updatedAt) VALUES (4, LAST_INSERT_ID(), 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Kus(content, upvotes, downvotes, lat, lon, createdAt, updatedAt) VALUES ("Haikus are easy;But sometimes they don't make sense;Refrigerator", 0, 0, 42.1, -71.34, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_users(userId, kuId, relationship, createdAt, updatedAt) VALUES (5, LAST_INSERT_ID(), 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Kus(content, upvotes, downvotes, lat, lon, createdAt, updatedAt) VALUES ("Space is limited;In a haiku so it's hard;to finish what you", 0, 0, 42.1, -71.34, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_users(userId, kuId, relationship, createdAt, updatedAt) VALUES (6, LAST_INSERT_ID(), 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Kus(content, upvotes, downvotes, lat, lon, createdAt, updatedAt) VALUES ("Hippopotamus;Anti-hippopotamus;Annihilation", 0, 0, 42.1, -71.34, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_users(userId, kuId, relationship, createdAt, updatedAt) VALUES (2, LAST_INSERT_ID(), 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Kus(content, upvotes, downvotes, lat, lon, createdAt, updatedAt) VALUES ("Expand your mind. Get;to work. Better yet, put your;feet up. Watch tv.", 0, 0, 42.1, -71.34, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_users(userId, kuId, relationship, createdAt, updatedAt) VALUES (3, LAST_INSERT_ID(), 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Kus(content, upvotes, downvotes, lat, lon, createdAt, updatedAt) VALUES ("How many lightbulbs;Does it take to screw a shrink;Oh, got it backwards", 0, 0, 42.1, -71.34, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_users(userId, kuId, relationship, createdAt, updatedAt) VALUES (1, LAST_INSERT_ID(), 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Kus(content, upvotes, downvotes, lat, lon, createdAt, updatedAt) VALUES ("fuck shit goddamnit;motherfucking shit ow ow;fuck shit fuck fuck fuck", 0, 0, 42.1, -71.34, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_users(userId, kuId, relationship, createdAt, updatedAt) VALUES (4, LAST_INSERT_ID(), 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Kus(content, upvotes, downvotes, lat, lon, createdAt, updatedAt) VALUES ("Whatchamacallit?;Dgnabit those doohickeys;You know them wing-dings", 0, 0, 42.1, -71.34, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_users(userId, kuId, relationship, createdAt, updatedAt) VALUES (2, LAST_INSERT_ID(), 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Kus(content, upvotes, downvotes, lat, lon, createdAt, updatedAt) VALUES ("Gar, garble, gargle,;gargoyle, argyle, garbanzo,;gazebo, gazelle", 0, 0, 42.1, -71.34, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_users(userId, kuId, relationship, createdAt, updatedAt) VALUES (3, LAST_INSERT_ID(), 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Kus(content, upvotes, downvotes, lat, lon, createdAt, updatedAt) VALUES ("A headless horseman;Sits atop a big trapeze;Slowly passing gas", 0, 0, 42.1, -71.34, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_users(userId, kuId, relationship, createdAt, updatedAt) VALUES (2, LAST_INSERT_ID(), 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Create Comments
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('I love you', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (4, LAST_INSERT_ID(), 1, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('this is the last test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (3, LAST_INSERT_ID(), 1, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is another test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (5, LAST_INSERT_ID(), 1, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('check me', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (4, LAST_INSERT_ID(), 1, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is another test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (3, LAST_INSERT_ID(), 2, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('check me', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (3, LAST_INSERT_ID(), 2, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is okay', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (6, LAST_INSERT_ID(), 2, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is another test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (5, LAST_INSERT_ID(), 3, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('I blue myself', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (5, LAST_INSERT_ID(), 3, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('I love you', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (4, LAST_INSERT_ID(), 3, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('u fokken wot m8', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (2, LAST_INSERT_ID(), 3, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('check me', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (4, LAST_INSERT_ID(), 4, True, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('this is the last test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (3, LAST_INSERT_ID(), 4, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('ur so clevar', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (6, LAST_INSERT_ID(), 4, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is another test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (3, LAST_INSERT_ID(), 4, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('check me', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (5, LAST_INSERT_ID(), 5, True, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('I love you', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (5, LAST_INSERT_ID(), 5, True, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is another test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (4, LAST_INSERT_ID(), 6, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is okay', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (1, LAST_INSERT_ID(), 6, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('check me', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (2, LAST_INSERT_ID(), 6, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('I love you', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (4, LAST_INSERT_ID(), 7, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('marry me', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (1, LAST_INSERT_ID(), 7, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('this shit sucks', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (4, LAST_INSERT_ID(), 7, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is a test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (2, LAST_INSERT_ID(), 7, True, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('this is the last test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (3, LAST_INSERT_ID(), 7, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is another test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (2, LAST_INSERT_ID(), 8, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('this shit sucks', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (3, LAST_INSERT_ID(), 8, True, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('I love you', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (2, LAST_INSERT_ID(), 8, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('I blue myself', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (5, LAST_INSERT_ID(), 9, True, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is another test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (5, LAST_INSERT_ID(), 9, True, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is okay', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (4, LAST_INSERT_ID(), 9, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('I love you', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (2, LAST_INSERT_ID(), 9, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is another test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (4, LAST_INSERT_ID(), 10, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('marry me', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (3, LAST_INSERT_ID(), 11, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('this shit sucks', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (6, LAST_INSERT_ID(), 11, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is another test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (5, LAST_INSERT_ID(), 12, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('check me', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (4, LAST_INSERT_ID(), 12, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('marry me', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (5, LAST_INSERT_ID(), 12, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('this shit sucks', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (5, LAST_INSERT_ID(), 12, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('this shit sucks', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (2, LAST_INSERT_ID(), 13, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('ur so clevar', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (1, LAST_INSERT_ID(), 13, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is okay', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (4, LAST_INSERT_ID(), 14, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('I love you', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (3, LAST_INSERT_ID(), 15, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('marry me', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (1, LAST_INSERT_ID(), 15, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is a test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (3, LAST_INSERT_ID(), 15, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('I love you', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (4, LAST_INSERT_ID(), 1, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('this is the last test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (3, LAST_INSERT_ID(), 1, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is another test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (5, LAST_INSERT_ID(), 1, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('check me', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (4, LAST_INSERT_ID(), 1, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is another test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (3, LAST_INSERT_ID(), 2, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('check me', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (3, LAST_INSERT_ID(), 2, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is okay', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (6, LAST_INSERT_ID(), 2, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is another test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (5, LAST_INSERT_ID(), 3, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('I blue myself', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (5, LAST_INSERT_ID(), 3, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('I love you', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (4, LAST_INSERT_ID(), 3, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('u fokken wot m8', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (2, LAST_INSERT_ID(), 3, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('check me', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (4, LAST_INSERT_ID(), 4, True, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('this is the last test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (3, LAST_INSERT_ID(), 4, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('ur so clevar', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (6, LAST_INSERT_ID(), 4, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is another test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (3, LAST_INSERT_ID(), 4, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('check me', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (5, LAST_INSERT_ID(), 5, True, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('I love you', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (5, LAST_INSERT_ID(), 5, True, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is another test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (4, LAST_INSERT_ID(), 6, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is okay', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (1, LAST_INSERT_ID(), 6, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('check me', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (2, LAST_INSERT_ID(), 6, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('I love you', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (4, LAST_INSERT_ID(), 7, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('marry me', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (1, LAST_INSERT_ID(), 7, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('this shit sucks', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (4, LAST_INSERT_ID(), 7, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is a test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (2, LAST_INSERT_ID(), 7, True, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('this is the last test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (3, LAST_INSERT_ID(), 7, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is another test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (2, LAST_INSERT_ID(), 8, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('this shit sucks', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (3, LAST_INSERT_ID(), 8, True, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('I love you', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (2, LAST_INSERT_ID(), 8, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('I blue myself', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (5, LAST_INSERT_ID(), 9, True, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is another test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (5, LAST_INSERT_ID(), 9, True, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is okay', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (4, LAST_INSERT_ID(), 9, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('I love you', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (2, LAST_INSERT_ID(), 9, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is another test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (4, LAST_INSERT_ID(), 10, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('marry me', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (3, LAST_INSERT_ID(), 11, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('this shit sucks', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (6, LAST_INSERT_ID(), 11, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is another test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (5, LAST_INSERT_ID(), 12, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('check me', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (4, LAST_INSERT_ID(), 12, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('marry me', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (5, LAST_INSERT_ID(), 12, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('this shit sucks', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (5, LAST_INSERT_ID(), 12, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('this shit sucks', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (2, LAST_INSERT_ID(), 13, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('ur so clevar', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (1, LAST_INSERT_ID(), 13, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is okay', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (4, LAST_INSERT_ID(), 14, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('I love you', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (3, LAST_INSERT_ID(), 15, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('marry me', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (1, LAST_INSERT_ID(), 15, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES ('This is a test', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO Ku_comment_users(userId, commentId, kuId, relationship, createdAt, updatedAt) VALUES (3, LAST_INSERT_ID(), 15, False, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);