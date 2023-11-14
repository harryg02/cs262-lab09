-- 8.1
-- Retrieve a list of all the games, ordered by date with the most recent game coming first.
SELECT * FROM Game
ORDER BY time DESC;
-- Retrieve all the games that occurred in the past week.
SELECT * FROM Game
WHERE time >= NOW() - INTERVAL 7 DAY;
-- Retrieve a list of players who have (non-NULL) names.
SELECT player
WHERE name IS NOT NULL;
-- Retrieve a list of IDs for players who have some game score larger than 2000.
SELECT DISTINCT playerID FROM PlayerGame -- The DISTINCT keyword ensures that each player ID appears only once in the result set, even if a player has multiple game scores greater than 2000.
WHERE score > 2000;
-- Retrieve a list of players who have GMail accounts.
SELECT * FROM Player
WHERE emailAddress LIKE '%@gmail.com';
-- 8.2
-- Retrieve all “The King”’s game scores in decreasing order.
SELECT PlayerGame.score
FROM PlayerGame
JOIN Player ON PlayerGame.playerID = Player.ID
WHERE Player.name = 'The King'
ORDER BY PlayerGame.score DESC;
-- Retrieve the name of the winner of the game played on 2006-06-28 13:20:00.
SELECT Player.name
FROM Player, PlayerGame, Game
WHERE Game.ID = PlayerGame.gameID 
AND Player.ID = PlayerGame.playerID
AND Game.time = '2006-06-28 13:20:00'
ORDER BY PlayerGame.score DESC
LIMIT 1;
-- So what does that P1.ID < P2.ID clause do in the last example query (i.e., the from SQL Examples)?
--The purpose of the query is to find pairs of players who have the same name but different IDs.

-- The query that joined the Player table to itself seems rather contrived. Can you think of a realistic situation in which you’d want to join a table to itself?
-- Yes, For example Finding Pairs of Players with the Same Cash Amount. This would 
-- require comparing each player's cash amount with every other player's cash amount.

