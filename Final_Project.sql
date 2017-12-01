---Trevor Pirone---
---DBMS 308---
---Final Project---
---Mario Super Sluggers Database SQL File----
---2/04/17---

---Drop statements that will delete views, functions, tables, triggers, and roles if they exist.---
DROP VIEW IF EXISTS view_all_characters_with_team_and_stats, view_all_stadiums_with_minigames, view_captain_banana_swing_or_fireball, minigames_with_hi_score_greater_than_4000;
DROP FUNCTION IF EXISTS locatePlayer(TEXT); 
DROP FUNCTION IF EXISTS teamOwn(TEXT);
DROP FUNCTION IF EXISTS showRoster(TEXT); 
DROP FUNCTION IF EXISTS newStat() CASCADE;
DROP FUNCTION IF EXISTS newMinigame() CASCADE;
DROP TABLE IF EXISTS Characters, Captains, Special_Characters, Stats, Teams, hasTeam, playsFor, Stadiums, hasStadium, Items, Minigames, hasItems, hasMinigame;
DROP ROLE IF EXISTS ADMIN, CAPTAIN, GUEST;

---Characters Table---
CREATE TABLE Characters (
	char_id INT NOT NULL,
	name TEXT NOT NULL,
	biography TEXT NOT NULL,
	bats TEXT NOT NULL,
	throws TEXT NOT NULL,
	running TEXT NOT NULL,
	fielding TEXT NOT NULL,
	UNIQUE(char_id),
	PRIMARY KEY(char_id)
);

---Captains Table---
CREATE TABLE Captains (
	cap_id INT NOT NULL,
	star_pitch TEXT NOT NULL,
	star_swing TEXT NOT NULL,
	UNIQUE(cap_id),
	PRIMARY KEY(cap_id)
);

---Special_Characters Table---
CREATE TABLE Special_Characters (
	char_id INT REFERENCES Characters(char_id),
	cap_id INT REFERENCES Captains(cap_id),
	PRIMARY KEY(char_id, cap_id)
);

---Stats Table---
CREATE TABLE Stats (	
	char_id INT REFERENCES Characters(char_id),
	pitch INT NOT NULL,
	CHECK (pitch >= 0),
	bat INT NOT NULL,
	CHECK (bat >= 0),
	field INT NOT NULL,
	CHECK (field >= 0),
	run INT NOT NULL,
	CHECK (run >= 0),
	UNIQUE(char_id),
	PRIMARY KEY(char_id)
);

---Teams Table---
CREATE TABLE Teams (
	team_id INT NOT NULL,
	team_name TEXT NOT NULL,
	team_info TEXT NOT NULL,
	UNIQUE(team_id),
	PRIMARY KEY(team_id)
);

---hasTeam Table---
CREATE TABLE hasTeam (
	cap_id INT REFERENCES Captains(cap_id),
	team_id INT REFERENCES Teams(team_id),
	PRIMARY KEY(cap_id, team_id)
);

---playsFor Table---
CREATE TABLE playsFor (
	char_id INT REFERENCES Characters(char_id),
	team_id INT REFERENCES Teams(team_id),
	PRIMARY KEY(char_id, team_id)
);

---Stadiums Table---
CREATE TABLE Stadiums (
	stadium_id INT NOT NULL,
	field_name TEXT NOT NULL,
	day_mode BOOLEAN NOT NULL,
	night_mode BOOLEAN NOT NULL,
	hazards TEXT NOT NULL,
	UNIQUE(stadium_id),
	PRIMARY KEY(stadium_id)
);

---hasStadium Table---
CREATE TABLE hasStadium (
	team_id INT REFERENCES Teams(team_id),
	stadium_id INT REFERENCES Stadiums(stadium_id),
	PRIMARY KEY(team_id, stadium_id)
);

---Items Table---
CREATE TABLE Items (
	item_id INT NOT NULL,
	item_name TEXT NOT NULL,
	item_desc TEXT NOT NULL,
	UNIQUE(item_id),
	PRIMARY KEY(item_id)
);

---Minigames Table---
CREATE TABLE Minigames (
	minigame_id INT NOT NULL,
	game_name TEXT NOT NULL,
	game_desc TEXT NOT NULL,
	hi_score INT NOT NULL,
	CHECK (hi_score >= 0),
	UNIQUE(minigame_id),
	PRIMARY KEY(minigame_id)
);

---hasItems Table---
CREATE TABLE hasItems (
	stadium_id INT REFERENCES Stadiums(stadium_id),
	item_id INT REFERENCES Items(item_id),
	PRIMARY KEY(stadium_id, item_id)
);

---hasMinigame Table---
CREATE TABLE hasMinigame (
	stadium_id INT REFERENCES Stadiums(stadium_id),
	minigame_id INT REFERENCES Minigames(minigame_id),
	PRIMARY KEY(stadium_id, minigame_id)
);

---Inserting values into the characters table. All of these characters (besides Alan Labouseur) are actually in the game with these exact values for each key.---
INSERT INTO Characters(char_id, name, biography, bats, throws, running, fielding) VALUES
(1, 'Mario', 'A 5-tool player who can hit, run, and pitch!', 'Right', 'Right', 'Enlarge', 'None'),
(2, 'Luigi', 'A 5-tool player who can jump, pitch, and hit!', 'Left', 'Right', 'None', 'Super Jump'),
(3, 'Peach', 'A slap hitter who can pitch the lights out.', 'Right', 'Right', 'None', 'Quick Throw'),
(4, 'Daisy', 'Her amazing glove is her best feature.', 'Left', 'Right', 'None', 'Super Dive'),
(5, 'Yoshi', 'Top-class speed in the field and on base.', 'Left', 'Right', 'None', 'Tongue Catch'),
(6, 'Birdo', 'A good player who has trouble hitting curves.', 'Right', 'Right', 'None', 'Suction Catch'),
(7, 'Wario', 'Good stamina and a great contact zone.', 'Right', 'Right', 'None', 'Laser Beam'),
(8, 'Waluigi', 'Charge swings drop power, but increase hits.', 'Left', 'Left', 'None', 'Quick Throw'),
(9, 'Donkey Kong', 'A strong hitter who can also climb walls.', 'Left', 'Right', 'None', 'Clamber'),
(10, 'Diddy Kong', 'His hits and pitches move like crazy!', 'Left', 'Right', 'None', 'Clamber'),
(11, 'Bowser', 'His speed and stamina baffles batters!', 'Left', 'Right', 'Spin Attack', 'None'),
(12, 'Bowser Jr.', 'A pitcher with great ball and bat control!', 'Right', 'Left', 'Spin Attack', 'None'),
(13, 'Baby Mario', 'Small and fast, he''s the master of close plays!', 'Right', 'Right', 'Enlarge', 'None'),
(14, 'Baby Luigi', 'An outstanding fielder who can also pitch.', 'Left', 'Right', 'None', 'Super Jump'),
(15, 'Baby Peach', 'Owner of the wickedest curve around.', 'Right', 'Right', 'None', 'Quick Throw'),
(16, 'Baby Daisy', 'A nasty curve makes up for a lack of power.', 'Left', 'Right', 'None', 'Super Dive'),
(17, 'Baby DK', 'A mini dynamo who can clamber and field!', 'Left', 'Right', 'None', 'Clamber'),
(18, 'Toad', 'A well-balanced Toad who throws a decent pitch.', 'Right', 'Right', 'Enlarge', 'None'),
(19, 'Toadette', 'A steal machine with speed to spare.', 'Right', 'Right', 'Enlarge', 'None'),
(20, 'Toadsworth', 'A masterful pitcher who tires easily.', 'Right', 'Right', 'Enlarge', 'None'),
(21, 'Blue Pianta', 'Strong but slow, with a powerful arm.', 'Right', 'Right', 'None', 'Laser Beam'),
(22, 'Blue Noki', 'A speedy guy who runs faster with the ball.', 'Left', 'Right', 'None', 'Ball Dash'),
(23, 'Dixie Kong', 'A defensive gem who can also climb walls.', 'Left', 'Right', 'None', 'Clamber'),
(24, 'Funky Kong', 'A powerhouse with slow charge pitches.', 'Right', 'Left', 'None', 'Clamber'),
(25, 'Tiny Kong', 'A well-rounded player with a mean curve!', 'Left', 'Right', 'None', 'Clamber'),
(26, 'King K. Rool', 'Dominating bat and arm, but poor stamina.', 'Right', 'Left', 'None', 'Laser Beam'),
(27, 'Kritter', 'A brute whose glove work hides his slow feet.', 'Left', 'Right', 'None', 'Keeper Catch'),
(28, 'Goomba', 'A good bunter who also pitches well.', 'Right', 'Right', 'None', 'Ball Dash'),
(29, 'Paragoomba', 'A defensive specialist with great hops!', 'Right', 'Right', 'None', 'Super Jump'),
(30, 'Koopa Troopa', 'A steady bat with low power and some speed.', 'Left', 'Right', 'Spin Attack', 'None'),
(31, 'Paratroopa', 'Uses super jumps to catch high flies.', 'Left', 'Right', 'None', 'Super Jump'),
(32, 'Magikoopa', 'A good pitcher, but an amazing fielder.', 'Left', 'Right', 'None', 'Magical Catch'),
(33, 'Hammer Bro', 'His hammer can catch distant balls.', 'Right', 'Right', 'None', 'Hammer Throw'),
(34, 'Dry Bones', 'A Dry Bones who can avoid most tags.', 'Left', 'Left', 'Scatter Dive', 'None'),
(35, 'Boo', 'Excellent bat control, but poor power.', 'Left', 'Left', 'Teleport', 'None'),
(36, 'King Boo', 'A decent player with poor defense.', 'Right', 'Right', 'Teleport', 'None'),
(37, 'Petey Piranha', 'A power hitter who swings for the fences!', 'Left', 'Neither', 'None', 'Piranha Catch'),
(38, 'Wiggler', 'A player with more speed than you''d think.', 'Left', 'Right', 'Angry Attack', 'None'),
(39, 'Shy Guy', 'An all-around player with a nice glove.', 'Left', 'Right', 'None', 'Super Dive'),
(40, 'Monty Mole', 'A skilled bunter with good speed!', 'Left', 'Right', 'Burrow', 'None'),
(41, 'Blooper', 'A true master of the changeup pitch!', 'Left', 'Right', 'Ink Dive', 'None'),
(42, 'Red Yoshi', 'A speedy Yoshi with all-around skills.', 'Left', 'Right', 'None', 'Tongue Catch'),
(43, 'Blue Yoshi', 'A speedy Yoshi with a decent arm.', 'Left', 'Right', 'None', 'Tongue Catch'),
(44, 'Yellow Yoshi', 'A speedy Yoshi with a decent bat.', 'Left', 'Right', 'None', 'Tongue Catch'),
(45, 'Light Blue Yoshi', 'A speedy Yoshi with a decent glove.', 'Left', 'Right', 'None', 'Tongue Catch'),
(46, 'Pink Yoshi', 'An extra-speedy Yoshi who loves to run.', 'Left', 'Right', 'None', 'Tongue Catch'),
(47, 'Blue Toad', 'A well-balanced Toad with extra batting power.', 'Right', 'Right', 'Enlarge', 'None'),
(48, 'Yellow Toad', 'A well-balanced Toad with a fine glove.', 'Right', 'Right', 'Enlarge', 'None'),
(49, 'Green Toad', 'A Toad with decent stats all around.', 'Right', 'Right', 'Enlarge', 'None'),
(50, 'Purple Toad', 'A well-balanced Toad with a lively bat.', 'Right', 'Right', 'Enlarge', 'None'),
(51, 'Red Pianta', 'A defensive specialist among Piantas.', 'Right', 'Right', 'None', 'Laser Beam'),
(52, 'Yellow Pianta', 'His brawn give pitches extra oomph!', 'Right', 'Right', 'None', 'Laser Beam'),
(53, 'Red Noki', 'A defensive specialist among Nokis.', 'Left', 'Right', 'None', 'Ball Dash'),
(54, 'Green Noki', 'A speedy guy with decent power to boot.', 'Left', 'Right', 'None', 'Ball Dash'),
(55, 'Blue Kritter', 'A true brute with a good arm!', 'Left', 'Right', 'None', 'Keeper Catch'),
(56, 'Red Kritter', 'A true brute who wields a big bat.', 'Left', 'Right', 'None', 'Keeper Catch'),
(57, 'Brown Kritter', 'A true brute who can run a bit.', 'Left', 'Right', 'None', 'Keeper Catch'),
(58, 'Red Koopa Troopa', 'A player who can use a spin attack.', 'Left', 'Right', 'Spin Attack', 'None'),
(59, 'Green Paratroopa', 'A balanced player with a bit of pop.', 'Left', 'Right', 'None', 'Super Jump'),
(60, 'Red Magikoopa', 'Good stamina and a great contact zone.', 'Left', 'Right', 'None', 'Magical Catch'),
(61, 'Green Magikoopa', 'A nice player with a good bat and glove.', 'Left', 'Right', 'None', 'Magical Catch'),
(62, 'Yellow Magikoopa', 'A steady guy with a decent bat and glove.', 'Left', 'Right', 'None', 'Magical Catch'),
(63, 'Fire Bro', 'A player with a mighty charge swing!', 'Right', 'Right', 'None', 'Fire Throw'),
(64, 'Boomerang Bro', 'A player who throws a mean curveball!', 'Right', 'Right', 'None', 'Bommerang Throw'),
(65, 'Green Dry Bones', 'A powerful Dry Bones with quick feet.', 'Left', 'Left', 'Scatter Dive', 'None'),
(66, 'Dark Bones', 'A powerful Dry Bones with a good arm.', 'Left', 'Left', 'Scatter Dive', 'None'),
(67, 'Blue Dry Bones', 'A powerful Dry Bones with a good glove.', 'Left', 'Left', 'Scatter Dive', 'None'),
(68, 'Blue Shy Guy', 'A Shy Guy who loves to pitch!', 'Left', 'Right', 'None', 'Super Dive'),
(69, 'Yellow Shy Guy', 'A Shy Guy who loves to steal!', 'Left', 'Right', 'None', 'Super Dive'),
(70, 'Green Shy Guy', 'A Shy Guy who loves to hit and run!', 'Left', 'Right', 'None', 'Super Dive'),
(71, 'Gray Shy Guy', 'A Shy Guy who loves to play the field!', 'Left', 'Right', 'None', 'Super Dive'),
(72, 'Male Mii', 'A 5-tool player that can do it all!', 'Right', 'Right', 'None', 'Quick Throw'),
(73, 'Female Mii', 'A 5-tool player that can do it all!', 'Left', 'Right', 'None', 'Quick Throw'),
(74, 'Alan Labouseur', 'A straight up savage and boss!', 'Both', 'Both', 'Enlarge', 'Super Jump');

---Inserting values into the Captains table. Each captain has their own star pitch and star swing special.---
INSERT INTO Captains(cap_id, star_pitch, star_swing) VALUES
(1, 'Fireball', 'Fire Swing'),
(2, 'Tornado Ball', 'Tornado Swing'),
(3, 'Heart Ball', 'Heart Swing'),
(4, 'Flower Ball', 'Flower Swing'),
(5, 'Rainbow Ball', 'Egg Swing'),
(6, 'Suction Ball', 'Cannon Swing'),
(7, 'Phony Ball', 'Phony Swing'),
(8, 'Liar Ball', 'Liar Swing'),
(9, 'Barrel Ball', 'Barrel Swing'),
(10, 'Banana Ball', 'Banana Swing'),
(11, 'Killer Ball', 'Breath Swing'),
(12, 'Grafitti Ball', 'Grafitti Swing');

---Inserting values into the Special_Characters table.---
INSERT INTO Special_Characters(char_id, cap_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12);

---Inserting values into the Stats table. These stats are accurate for every single character in the game (including Miis).---
INSERT INTO Stats(char_id, pitch, bat, field, run) VALUES
(1, 6, 7, 6, 7),
(2, 6, 6, 7, 7),
(3, 9, 4, 8, 5),
(4, 7, 6, 8, 5),
(5, 4, 4, 6, 9),
(6, 4, 8, 7, 5),
(7, 5, 8, 3, 4),
(8, 8, 4, 8, 5),
(9, 6, 9, 3, 2),
(10, 5, 4, 8, 6),
(11, 5, 10, 3, 3),
(12, 5, 7, 4, 7),
(13, 5, 3, 4, 8),
(14, 5, 2, 5, 8),
(15, 8, 2, 5, 6),
(16, 6, 4, 5, 6),
(17, 3, 6, 8, 4),
(18, 5, 5, 3, 7),
(19, 5, 3, 4, 8),
(20, 7, 3, 7, 3),
(21, 5, 8, 4, 2),
(22, 5, 4, 4, 7),
(23, 3, 3, 8, 7),
(24, 4, 8, 6, 3),
(25, 5, 5, 7, 5),
(26, 6, 10, 2, 1),
(27, 4, 7, 7, 3),
(28, 6, 3, 6, 4),
(29, 6, 3, 7, 5),
(30, 3, 6, 4, 6),
(31, 4, 4, 7, 5),
(32, 8, 2, 8, 2),
(33, 4, 7, 6, 3),
(34, 4, 7, 4, 5),
(35, 9, 3, 3, 5),
(36, 7, 7, 3, 4),
(37, 4, 10, 5, 2),
(38, 3, 7, 4, 7),
(39, 4, 5, 7, 4),
(40, 4, 4, 5, 7),
(41, 6, 4, 5, 6),
(42, 3, 4, 4, 8),
(43, 4, 2, 6, 8),
(44, 3, 4, 6, 7),
(45, 3, 3, 6, 8),
(46, 2, 3, 6, 9),
(47, 4, 6, 3, 7),
(48, 3, 6, 4, 7),
(49, 4, 5, 4, 7),
(50, 5, 6, 2, 7),
(51, 4, 8, 4, 2),
(52, 4, 8, 4, 2),
(53, 4, 4, 5, 7),
(54, 4, 5, 4, 7),
(55, 5, 6, 7, 3),
(56, 3, 8, 7, 3),
(57, 3, 7, 7, 4),
(58, 4, 6, 3, 6),
(59, 3, 5, 7, 5),
(60, 8, 3, 8, 1),
(61, 7, 2, 8, 2),
(62, 7, 3, 8, 2),
(63, 3, 8, 6, 3),
(64, 5, 7, 5, 3),
(65, 3, 7, 4, 6),
(66, 5, 7, 4, 5),
(67, 3, 7, 5, 5),
(68, 5, 4, 7, 4),
(69, 4, 4, 7, 5),
(70, 3, 5, 7, 5),
(71, 4, 4, 8, 4),
(72, 6, 6, 6, 6),
(73, 6, 6, 6, 6),
(74, 10, 10, 10, 10);

---Inserting values into the Teams table. Besides free agents, these are all valid team names and info (if the team has any information).---
INSERT INTO Teams(team_id, team_name, team_info) VALUES
(0, 'Free Agent', 'Free Agent'),
(1, 'Mario Fireballs', 'The Mario Fireballs are well balanced.'),
(2, 'Luigi Knights', 'No description exists.'),
(3, 'Peach Monarchs', 'The Peach Monarchs excel at pitching and defense.'),
(4, 'Daisy Flowers', 'No description exists.'),
(5, 'Yoshi Eggs', 'The Yoshi Eggs rely on their great team speed.'),
(6, 'Birdo Bows', 'No descriptiuon exists.'),
(7, 'Wario Muscles', 'The Wario Muscles are an odd, tricky bunch.'),
(8, 'Waluigi Spitballs', 'No description exists.'),
(9, 'DK Wilds', 'The DK Wilds rely on power and defense.'),
(10, 'Diddy Monkeys', 'No description exists.'),
(11, 'Bowser Monsters', 'The Bowser Monsters are a balanced and mighty team.'),
(12, 'Bowser Jr. Rookies', 'No description exists.');

---Inserting values into the hasTeam table.---
INSERT INTO hasTeam(cap_id, team_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12);

---Inserting values into the playsFor table. This table is interesting because it shows all characters and the teams they belong to.---
INSERT INTO playsFor(char_id, team_id) VALUES
(1, 1),
(2, 1),
(3, 3),
(4, 3),
(5, 5),
(6, 5),
(7, 7),
(8, 7),
(9, 9),
(10, 9),
(11, 11),
(12, 11),
(13, 1),
(14, 1),
(15, 3),
(16, 3),
(17, 9),
(18, 3),
(19, 3),
(20, 3),
(21, 1),
(22, 1),
(23, 9),
(24, 9),
(25, 9),
(26, 9),
(27, 9),
(28, 7),
(29, 7),
(30, 7),
(31, 7),
(32, 11),
(33, 11),
(34, 11),
(35, 7),
(36, 7),
(37, 3),
(38, 5),
(39, 5),
(40, 1),
(41, 1),
(42, 5),
(43, 5),
(44, 5),
(45, 5),
(46, 5),
(47, 3),
(48, 3),
(49, 3),
(50, 3),
(51, 1),
(52, 1),
(53, 1),
(54, 1),
(55, 9),
(56, 9),
(57, 9),
(58, 7),
(59, 7),
(60, 11),
(61, 11),
(62, 11),
(63, 11),
(64, 11),
(65, 11),
(66, 11),
(67, 11),
(68, 5),
(69, 5),
(70, 5),
(71, 5),
(72, 0),
(73, 0),
(74, 0);

---Inserting values into the Stadiums table. These values are indicative to the characteristics of each stadium in the actual game.---
INSERT INTO Stadiums(stadium_id, field_name, day_mode, night_mode, hazards) VALUES
(0, 'None', FALSE, FALSE, 'None'),
(1, 'Mario Stadium', TRUE, TRUE, 'None'),
(2, 'Peach Ice Garden', TRUE, TRUE, 'Freezies/Snowflakes'),
(3, 'Yoshi Park', TRUE, TRUE, 'Steam Train/Warp Pipes'),
(4, 'Wario City', TRUE, TRUE, 'Manholes/Directional Arrows'),
(5, 'DK Jungle', TRUE, TRUE, 'Barrels/Giant Flowers'),
(6, 'Luigi''s Mansion', FALSE, TRUE, 'Gravestones/Tall Grass'),
(7, 'Daisy Cruiser', TRUE, TRUE, 'Dining Tables/Cheep Cheeps/Glooper Blooper'),
(8, 'Bowser Jr. Playroom', TRUE, FALSE, 'Thwomps/ Chain Chomps/Bullet Bills'),
(9, 'Bowser Castle', FALSE, TRUE, 'Lava Puddles/King Bob-omb/Bowser Statue');

---Inserting values into the hasStadium table.---
INSERT INTO hasStadium(team_id, stadium_id) VALUES
(1, 1),
(2, 6),
(3, 2),
(4, 7),
(5, 3),
(6, 0),
(7, 4),
(8, 0),
(9, 5),
(10, 0),
(11, 9),
(12, 8);

---Inserting values into the Items table. Someitems are unique to certain gamemodes, but the database does not take that into account, so assume all items could be used in every game.---
INSERT INTO Items(item_id, item_name, item_desc) VALUES
(1, 'Green Shell', 'Shoots at a player and dazes if it hits.'),
(2, 'Fire Ball', 'Some fireballs bounce to burn someone.'),
(3, 'Mini Boos', 'Makes the ball and its shadow invisible for about six seconds. The ball can still be caught and revealed. Does not work when a Star Swing is used.'),
(4, 'Bob-omb', 'When a Bob-omb gets shot in the outfield, it sits and stay until it explodes. When it explodes, anyone caught in the explosion gets knocked away.'),
(5, 'POW-Ball', 'All fielders are stunned by a small earthquake for about four seconds when it hits the ground. This does not affect levitating characters or if the characters jump at the right moment. If the POW-Ball happens to hit a player itself, then the player hit by it gets knocked away and the small earthquake caused by it does not take effect.'),
(6, 'Banana Peel', 'Five bananas are shot out to slip the outfielders.'),
(7, 'Lightning Bolt', 'Will strike any characters on the screen.'),
(8, 'Alan''s Magic Staff', 'All max stats on every player for the rest of the inning. Very rare!');

---Inserting values into the Minigames table. Besides made-up high scores, these minigames exist in the game.---
INSERT INTO Minigames(minigame_id, game_name, game_desc, hi_score) VALUES
(1, 'Bob-omb Derby', 'Hit bob-ombs into the sky and earn as many points as you can!', 6000),
(2, 'Wall Ball', 'Thorw the ball at the walls to break them and earn the most points!', 5000),
(3, 'Piranha Panic', 'Prevent the piranha plants from reaching your player by throwing baseballs at them!', 4000),
(4, 'Gem Catch', 'Maneuver the player to catch gems to earn points! The more valuable gem, the more points can be earned!', 3500),
(5, 'Barrel Basher', 'Fend off barrels and bob-ombs by hitting them with baseballs protecting your shield!', 2500),
(6, 'Ghost K', 'Throw baseballs at the ghosts on the screen to make them disappear!', 3000),
(7, 'Blooper Baserun', 'Collect the most coins by ruinning around the bases! Be careful! Don''t hit the Glooper Blooper''s tentacles!', 4000),
(8, 'Grafitti Runner', 'Paint as much of the canvas as you can by running around with the paintbrush!', 3500),
(9, 'Bowser Pinball', 'Keep a spiked ball within the area and hit coins and walls to earn points!', 5000);

---Inserting values into the hasItems table.---
INSERT INTO hasItems(stadium_id, item_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(2, 6),
(2, 7),
(2, 8),
(3, 1),
(3, 2),
(3, 3),
(3, 4),
(3, 5),
(3, 6),
(3, 7),
(3, 8),
(4, 1),
(4, 2),
(4, 3),
(4, 4),
(4, 5),
(4, 6),
(4, 7),
(4, 8),
(5, 1),
(5, 2),
(5, 3),
(5, 4),
(5, 5),
(5, 6),
(5, 7),
(5, 8),
(6, 1),
(6, 2),
(6, 3),
(6, 4),
(6, 5),
(6, 6),
(6, 7),
(6, 8),
(7, 1),
(7, 2),
(7, 3),
(7, 4),
(7, 5),
(7, 6),
(7, 7),
(7, 8),
(8, 1),
(8, 2),
(8, 3),
(8, 4),
(8, 5),
(8, 6),
(8, 7),
(8, 8),
(9, 1),
(9, 2),
(9, 3),
(9, 4),
(9, 5),
(9, 6),
(9, 7),
(9, 8);

---Inserting values into the hasMinigame table.---
INSERT INTO hasMinigame(stadium_id, minigame_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9);

---Reports(General Queries)---

-------------------------------------------------------------------------------------
/*
 *Query 1
 *Get the names, ids, bat stats, and pitch stats of all players on the Wario Muscles 
 *with a batting stat greater than 6 or a pitching stat less than 4.
 */
SELECT playsFor.char_id, Characters.name, playsFor.team_id, bat, pitch
	FROM Characters, Teams, playsFor, Stats
	WHERE Characters.char_id = playsFor.char_id
	AND Teams.team_id = playsFor.team_id 
	AND playsFor.team_id = 7
	AND Characters.char_id = Stats.char_id
	AND (bat > 6 OR pitch < 4)
	GROUP BY playsFor.char_id, Characters.name, playsFor.team_id, bat, pitch
	ORDER BY Characters.name;
-------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------
/*
 *Query 2
 *Get the names, ids, and run stats of all captains that own a stadium where 
 *their run stat is greater than 5 in reverse alphabetical order.
 */
SELECT DISTINCT Characters.name, Special_Characters.char_id, Captains.cap_id, hasTeam.team_id, hasStadium.stadium_id, run
	FROM Characters, Special_Characters, Captains, hasTeam, Teams, hasStadium, Stadiums, Stats
	WHERE Characters.char_id = Special_Characters.char_id
	AND Special_Characters.cap_id = Captains.cap_id
	AND Captains.cap_id = hasTeam.cap_id
	AND hasTeam.team_id = Teams.team_id
	AND Teams.team_id = hasStadium.team_id
	AND hasStadium.stadium_id = Stadiums.stadium_id
	AND Stadiums.stadium_id != 0 
	AND Characters.char_id = Stats.char_id
	AND run > 5
	ORDER BY Characters.name DESC;
-------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------
/*
 *Query 3
 *Return the name and id of the character with the highest average of all stats.
 */
SELECT c.name, s.char_id, ROUND(AVG((pitch + bat + field + run) / 4.0), 2) AS Average
	FROM Characters c 
	INNER JOIN Stats s ON c.char_id = s.char_id
	GROUP BY s.char_id, c.name
	ORDER BY Average DESC
	LIMIT 1;
-------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------
/*
 *Query 4
 *Return the name and ids of the teams that play in a stadium that is 
 *only available in day or night mode. (i.e. one or the other, NOT both)
 */
SELECT t.team_id, t.team_name
	FROM Teams t
	FULL OUTER JOIN hasStadium h ON t.team_id = h.team_id
	FULL OUTER JOIN Stadiums s ON h.stadium_id = s.stadium_id
	WHERE (s.day_mode = TRUE AND s.night_mode = FALSE) 
	OR (s.day_mode = FALSE AND s.night_mode = TRUE) 
	GROUP BY t.team_id, t.team_name
	ORDER BY t.team_id ASC;
-------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------
/*
 *Query 5
 *Return the names, character ids, and the team name of all characters 
 *with a fielding stat larger than or equal to 7. (NOT including free agents.)
 */
SELECT Stats.char_id, name, team_name, field
	FROM Characters, Teams, playsFor, Stats
	WHERE Characters.char_id = playsFor.char_id
	AND playsFor.team_id = Teams.team_id
	AND Characters.char_id = Stats.char_id
	AND field >= 7
	AND Teams.team_id <> 0
	ORDER BY Teams.team_name ASC, field DESC, Characters.name;   
-------------------------------------------------------------------------------------

---Views---

-------------------------------------------------------------------------------------
/*
 *View 1
 *Create a view that returns all of the characters ids, names, name of their team, 
 *and their stats ordered by the team name and character name alphabetically, 
 *respectively.
 */
CREATE VIEW view_all_characters_with_team_and_stats AS
SELECT s.char_id, c.name, t.team_name, pitch, bat, field, run
	FROM Teams t
	INNER JOIN playsFor p ON t.team_id = p.team_id
	INNER JOIN Characters c ON c.char_id = p.char_id
	INNER JOIN Stats s ON s.char_id = c.char_id 
	GROUP BY s.char_id, c.name, t.team_name
	ORDER BY t.team_name ASC, c.name ASC;

SELECT *
	FROM view_all_characters_with_team_and_stats;
-------------------------------------------------------------------------------------	

-------------------------------------------------------------------------------------	
/*
 *View 2
 *Create a view that returns all information about stadiums with their 
 *corresponding minigames.
 */
CREATE VIEW view_all_stadiums_with_minigames AS
SELECT s.stadium_id, s.field_name, s.day_mode, s.night_mode, s.hazards, m.minigame_id, m.game_name , m.game_desc, m.hi_score
	FROM Stadiums s
	FULL OUTER JOIN hasMinigame h ON s.stadium_id = h.stadium_id
	FULL OUTER JOIN Minigames m ON h.minigame_id = m.minigame_id
	WHERE s.stadium_id != 0 OR m.minigame_id != 0
	GROUP BY s.stadium_id, s.field_name, s.day_mode, s.night_mode, s.hazards, m.minigame_id, m.game_name , m.game_desc, m.hi_score
	ORDER BY s.stadium_id, m.minigame_id;

SELECT *
	FROM view_all_stadiums_with_minigames;
-------------------------------------------------------------------------------------	

-------------------------------------------------------------------------------------	
/*
 *View 3
 *Return the ids, star pitches, and star swings of captains that have a Banana Swing 
 *or Fireball pitch.
 */
CREATE VIEW view_captain_banana_swing_or_fireball AS
SELECT *
	FROM Captains
	WHERE (star_swing = 'Banana Swing' OR star_pitch = 'Fireball')
	AND cap_id IN(SELECT char_id
			      FROM Special_Characters
			      WHERE char_id IN (SELECT char_id
							FROM Characters
							WHERE char_id > 0 AND char_id <= 12
					       )
		     );

SELECT *
	FROM view_captain_banana_swing_or_fireball;
-------------------------------------------------------------------------------------	

-------------------------------------------------------------------------------------	
/*
 *View 4
 *Return the id, name, and score of all minigames with a high score greater than 4000.
 */
CREATE VIEW minigames_with_hi_score_greater_than_4000 AS
SELECT minigame_id, game_name, hi_score, COUNT(minigame_id)
	FROM Minigames
	WHERE hi_score > 4000
	GROUP BY hi_score, minigame_id, game_name
	HAVING COUNT(minigame_id) > 0
	ORDER BY minigame_id;

SELECT *
	FROM minigames_with_hi_score_greater_than_4000;
-------------------------------------------------------------------------------------	

---Stored Procedures---

-------------------------------------------------------------------------------------
/*
 *Stored Procedure 1
 *Create a function that allows a user to input the name of the player and find the 
 *team they play for.
 */	
CREATE OR REPLACE FUNCTION locatePlayer(TEXT)
RETURNS TABLE(name TEXT, team_name TEXT) AS
	$$
	DECLARE
		findChar TEXT := $1;
	BEGIN
		RETURN QUERY
		SELECT Characters.name, Teams.team_name
		FROM Characters, playsFor, Teams
		WHERE Characters.char_id = playsFor.char_id
		AND playsFor.team_id = Teams.team_id
		AND Characters.name = findChar;
	END;
	$$ 
	LANGUAGE plpgsql;

SELECT locatePlayer('Alan Labouseur');
-------------------------------------------------------------------------------------	

-------------------------------------------------------------------------------------	
/*
 *Stored Procedure 2
 *Create a function that allows a user to input the name of the player and find the 
 *team they play for.
 */	
CREATE OR REPLACE FUNCTION teamOwn(TEXT)
RETURNS TABLE(name TEXT, team_name TEXT, field_name TEXT) AS
	$$
	DECLARE
		findOwner TEXT := $1;
	BEGIN
		RETURN QUERY
		SELECT c.name, t.team_name, s.field_name
		FROM Characters c
		INNER JOIN Special_Characters sc ON c.char_id = sc.char_id
		INNER JOIN Captains a ON sc.cap_id = a.cap_id
		INNER JOIN hasTeam h ON a.cap_id = h.cap_id
		INNER JOIN Teams t ON h.team_id = t.team_id
		INNER JOIN hasStadium d ON t.team_id = d.team_id
		INNER JOIN Stadiums s ON d.stadium_id = s.stadium_id
		WHERE c.name = findOwner
		GROUP BY c.name, t.team_name, s.field_name
		LIMIT 1;
	END;
	$$ 
	LANGUAGE plpgsql;

SELECT teamOwn('Daisy');
-------------------------------------------------------------------------------------	

-------------------------------------------------------------------------------------
/*
 *Stored Procedure 3
 *Create a function that allows the user to search for a team’s roster by inputting 
 *the name of the team. (Also works for free agents!)
 */	
CREATE OR REPLACE FUNCTION showRoster(TEXT)
RETURNS TABLE(team_name TEXT, name TEXT, char_id INT) AS
	$$
	DECLARE
		teamName TEXT := $1;
	BEGIN
		RETURN QUERY
		SELECT t.team_name, c.name, c.char_id
		FROM Characters c 
		FULL OUTER JOIN playsFor p ON c.char_id = p.char_id
		FULL OUTER JOIN Teams t ON p.team_id = t.team_id
		WHERE t.team_name = teamName
		GROUP BY t.team_name, c.name, c.char_id
		ORDER BY c.name, c.char_id;
	END
	$$ 
	LANGUAGE plpgsql;

SELECT showRoster('Free Agent');
-------------------------------------------------------------------------------------

---Triggers---

-------------------------------------------------------------------------------------
/*
 *Trigger 1
 *Create a trigger that checks if a player is added to the Characters table, 
 *when added to the stats table, if they have any stat less than zero or greater 
 *than 10, remove them from the database.
 */	
CREATE OR REPLACE FUNCTION newStat()
RETURNS TRIGGER AS
	$$
	BEGIN
		IF (NEW.bat > 10) OR (NEW.pitch > 10) OR (NEW.field > 10) OR (NEW.run> 10) THEN
		DELETE FROM Stats WHERE pitch = NEW.pitch;
		DELETE FROM Stats WHERE bat = NEW.bat;
		DELETE FROM Stats WHERE field = NEW.field;
		DELETE FROM Stats WHERE run = NEW.run;
		DELETE FROM Stats WHERE char_id = NEW.char_id;
		DELETE FROM Characters WHERE char_id = NEW.char_id;
		END IF;
		RETURN NEW;
	END;
	$$ 
	LANGUAGE plpgsql;

CREATE TRIGGER newStat
AFTER INSERT ON Stats
FOR EACH ROW
EXECUTE PROCEDURE newStat();

---Inserting a test value into the Characters table.---
INSERT INTO Characters(char_id, name, biography, bats, throws, running, fielding) VALUES
(75, 'Trevor Pirone', 'Really cute.', 'Right', 'Right', 'Enlarge', 'None');

---View all Characters (includes the new value just added.)---
SELECT * FROM Characters;

---Inserting stat values for the new character added.---
INSERT INTO Stats(char_id, pitch, bat, field, run) VALUES
(75, 11, 11, 11, 11);

---After the insert, the procedure realizes that there is invalid data being inserted. Thus, the function is triggered and the data is removed from all tables.---
---Updated results for Stats table after the deletion of Character 75.---
SELECT * FROM Stats;

---Updated results for SCharacters table after the deletion of Character 75.---
SELECT * FROM Characters;
-------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------
/*
 *Trigger 2
 *Create a trigger that checks if the high score of a new minigame is greater than 
 *9999 (the max value allowed in the game). If so, delete the minigame from the 
 *database.
 */	
CREATE OR REPLACE FUNCTION newMinigame()
RETURNS TRIGGER AS
	$$
	BEGIN
		IF (NEW.hi_score > 9999) THEN
		DELETE FROM Minigames WHERE minigame_id = NEW.minigame_id;
		DELETE FROM Minigames WHERE game_name = NEW.game_name;
		DELETE FROM Minigames WHERE game_desc = NEW.game_desc;
		DELETE FROM Minigames WHERE hi_score = NEW.hi_score;
		END IF;
		RETURN NEW;
	END;
	$$ 
	LANGUAGE plpgsql;

CREATE TRIGGER newMinigame
AFTER INSERT ON Minigames
FOR EACH ROW
EXECUTE PROCEDURE newMinigame();

---Inserting a test value for the Minigames table to test the trigger. Returns successfully.---
INSERT INTO Minigames(minigame_id, game_name, game_desc, hi_score) VALUES
(10, 'Coin Robbers', 'Catach the coins that are being thrown around the field. The player that catches the most amount of coins before the time runs out is the winner.', 10000);

---Before running the select statement below, the function was already triggered on the insert statement. When this statement is executed, the test value is already deleted from the database because it violates the trigger.---
SELECT * FROM Minigames;
-------------------------------------------------------------------------------------

---Roles---

-------------------------------------------------------------------------------------
/*
 *Admin Role
 *The admin will have access to modify all tables present in the database.
 */
CREATE ROLE ADMIN;
GRANT ALL 
ON ALL TABLES IN SCHEMA PUBLIC
TO ADMIN;
-------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------
/*
 *Captain Role
 *The captain will have the privilege to select, update, and delete information on 
 *teams, stadiums, and minigames.
 */
CREATE ROLE CAPTAIN;
GRANT SELECT, UPDATE, DELETE
ON Teams, Stadiums, Minigames
TO CAPTAIN; 
-------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------
/*
 *Guest Role
 *The guest can use select statements on all tables, but is revoked from inserting, 
 *updating, or deleting while interacting with the database.
 */
CREATE ROLE GUEST;
GRANT SELECT
ON ALL TABLES IN SCHEMA PUBLIC
TO GUEST;
REVOKE INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA PUBLIC
FROM GUEST;
-------------------------------------------------------------------------------------