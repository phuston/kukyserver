import random


usernames = ['Patrick', 'Keenan', 'Hieu', 'Franton', 'Bitch', 'Peter']

lat = 42.1
lon = -71.34


haikus = [['hello there patrick', 'this is a test oh boy yes', 'slowly passing gas', 1], 
		  ['an old silent pond', 'a frog jumps into the pond', 'SPLASH - silence again', 2],
		  ['alone in the rain', 'damp ones on my hairy legs', 'slowly passing gas', 3],
		  ['I wake, reluctant', 'too cold to get out of bed', 'but I need to pee', 4], 
		  ['Haikus are easy', 'But sometimes they don\'t make sense', 'Refrigerator', 5],
		  ['Space is limited', 'In a haiku so it\'s hard', 'to finish what you', 6],
		  ['Hippopotamus', 'Anti-hippopotamus', 'Annihilation', 2],
		  ['Expand your mind. Get', 'to work. Better yet, put your', 'feet up. Watch tv.', 3],
		  ['Testicles are fun', 'Unless you get kicked in them', 'That fucking sucks balls', 5],
		  ['How many lightbulbs', 'Does it take to screw a shrink', 'Oh, got it backwards', 1],
		  ['fuck shit goddamnit', 'motherfucking shit ow ow', 'fuck shit fuck fuck fuck', 4]]


comments = ['this shit sucks', 'I love you', 'This is okay', 'ur so clevar', 'marry me', 'u fokken wot m8', 'check me', 'I blue myself', 'This is a test', 'This is another test', 'this is the last test']


for user in usernames:
	print "INSERT INTO Users(Username, Score) VALUES (\'{}\', {});".format(user, 0)


for ku in haikus:
	ku_text = ';'.join(ku[0:3])
	print "INSERT INTO Kus(Content, Upvotes, Downvotes, Time, Lat, Lon) VALUES (\"{}\", {}, {}, CURRENT_TIMESTAMP, {}, {});".format(ku_text, 0, 0, lat, lon)
	print "INSERT INTO Ku_user VALUES ({}, LAST_INSERT_ID(), 0);".format(ku[3])

for index, ku in enumerate(haikus):
	ku_id = index+1
	rand_comments = random.sample(set(comments), random.randint(1,5))

	for comment in rand_comments:
		user_id = random.randint(1, len(usernames))
		print "INSERT INTO Comments(Content, Upvotes, Downvotes) VALUES (\'{}\', {}, {});".format(comment, 0, 0)
		print "INSERT INTO Ku_comment_user VALUES ({}, LAST_INSERT_ID(), {});".format(user_id, ku_id)



# query1 = "INSERT INTO Kus(Content, Upvotes, Downvotes, Time, Lat, Lon) VALUES (\'{}\', {}, {}, CURRENT_TIMESTAMP, {}, {});".format()


# query3 = "INSERT INTO Comments(Content, Upvotes, Downvotes) VALUES ({}, {}, {});".format()

# query4 = "INSERT INTO Ku_comment_user VALUES ({}, LAST_INSERT_ID(), {});".format()
