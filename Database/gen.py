import random


usernames = ['patrick', 'keenan', 'hieu', 'franton', 'bitch', 'peter']
hashedPasswords = ['atrickpay', 'eenankay', 'ieuhay', 'rantonfay', 'itchbay', 'eterpay']
apikeys = ['AIKzkIO91099ckLIK39cKEI', '91029KJDxiILk81kKI01929', '18xcCMU120lKqPZ182zXX', 'MEixck92lak9UsRI1291lXyz', 'AIz917CdkllVZcT1l99cdAm', 'OVA959lRIsUVYmc8SyCyazIA']

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
		  ['fuck shit goddamnit', 'motherfucking shit ow ow', 'fuck shit fuck fuck fuck', 4],
          ['Whatchamacallit?', 'Dgnabit those doohickeys', 'You know them wing-dings', 2],
          ['Gar, garble, gargle,', 'gargoyle, argyle, garbanzo,', 'gazebo, gazelle', 3],
          ['A headless horseman', 'Sits atop a big trapeze', 'Slowly passing gas', 2],
          ['Shit. It\'s nine. I\'m late', 'Quickly I shave, cut my face', 'Goddammit. Sunday.', 5]]


comments = ['this shit sucks', 'I love you', 'This is okay', 'ur so clevar', 'marry me', 
'u fokken wot m8', 'check me', 'I blue myself', 'This is a test', 'This is another test', 
'this is the last test']


# for i, user in enumerate(usernames):
#     print "INSERT INTO Users(Username, Score, radiusLimit, createdAt, updatedAt) VALUES (\'{}\', {}, {}, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);".format(user, 0, 2)
#     print "INSERT INTO User_auths VALUES (LAST_INSERT_ID(), \'{}\', \'{}\');".format(apikeys[i], hashedPasswords[i])

# for ku in haikus:
# 	ku_text = ';'.join(ku[0:3])
# 	print "INSERT INTO Kus(content, upvotes, downvotes, lat, lon, createdAt, updatedAt) VALUES (\"{}\", {}, {}, {}, {}, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);".format(ku_text, 0, 0, lat, lon)
# 	print "INSERT INTO Ku_users VALUES ({}, LAST_INSERT_ID(), 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);".format(ku[3])

for index, ku in enumerate(haikus):
    ku_id = index+1
    rand_comments = random.sample(set(comments), random.randint(1,5))
    
    for comment in rand_comments:
        user_id = random.randint(1, len(usernames))
        is_op = user_id == haikus[index][3]
        print "INSERT INTO Comments(content, upvotes, downvotes, createdAt, updatedAt) VALUES (\'{}\', {}, {}, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);".format(comment, 0, 0)
        print "INSERT INTO Ku_comment_users VALUES ({}, LAST_INSERT_ID(), {}, {}, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);".format(user_id, ku_id, is_op)



# query1 = "INSERT INTO Kus(Content, Upvotes, Downvotes, Time, Lat, Lon) VALUES (\'{}\', {}, {}, CURRENT_TIMESTAMP, {}, {});".format()


# query3 = "INSERT INTO Comments(Content, Upvotes, Downvotes) VALUES ({}, {}, {});".format()

# query4 = "INSERT INTO Ku_comment_user VALUES ({}, LAST_INSERT_ID(), {});".format()
