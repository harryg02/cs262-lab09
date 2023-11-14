--
-- This SQL script builds a monopoly database, deleting any pre-existing version.
--
-- @author kvlinden
-- @version Summer, 2015
--

-- Drop previous versions of the tables if they exist, in reverse order of foreign keys.
DROP TABLE IF EXISTS PlayerGame;
DROP TABLE IF EXISTS Game;
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS Player;

-- Create the Player table first.
CREATE TABLE Player (
    ID integer PRIMARY KEY, 
    emailAddress varchar(50) NOT NULL,
    name varchar(50)
);

-- Now, extend the Player table to include cash.
ALTER TABLE Player ADD COLUMN cash decimal(10,2) DEFAULT 1500.00; -- Default cash is $1500 in Monopoly.

-- Continue with the creation of other tables.
CREATE TABLE Game (
    ID integer PRIMARY KEY,
    time timestamp
);

CREATE TABLE PlayerGame (
    gameID integer REFERENCES Game(ID), 
    playerID integer REFERENCES Player(ID),
    score integer
);

CREATE TABLE Property (
    ID integer PRIMARY KEY,
    name varchar(50) NOT NULL,
    color varchar(20), -- e.g., 'Red', 'Green', etc.
    cost decimal(10,2),
    rent decimal(10,2),
    house_cost decimal(10,2),
    hotel_cost decimal(10,2),
    ownerID integer REFERENCES Player(ID), -- Owner of the property.
    houses integer DEFAULT 0, -- Number of houses on the property.
    hotel boolean DEFAULT false -- Whether there's a hotel on the property.
);

-- Extend the PlayerGame table to track the current location of each player's piece.
ALTER TABLE PlayerGame ADD COLUMN position integer DEFAULT 0; -- Default position is 'Go' which is position 0.

-- Allow users to select data from the tables.
GRANT SELECT ON Game TO PUBLIC;
GRANT SELECT ON Player TO PUBLIC;
GRANT SELECT ON PlayerGame TO PUBLIC;
GRANT SELECT ON Property TO PUBLIC;

-- Add sample records.
INSERT INTO Game VALUES (1, '2006-06-27 08:00:00');
INSERT INTO Game VALUES (2, '2006-06-28 13:20:00');
INSERT INTO Game VALUES (3, '2006-06-29 18:41:00');

INSERT INTO Player(ID, emailAddress) VALUES (1, 'me@calvin.edu');
INSERT INTO Player(ID, emailAddress, name) VALUES (2, 'king@gmail.edu', 'The King');
INSERT INTO Player(ID, emailAddress, name) VALUES (3, 'dog@gmail.edu', 'Dogbreath');

INSERT INTO PlayerGame VALUES (1, 1, 0.00);
INSERT INTO PlayerGame VALUES (1, 2, 0.00);
INSERT INTO PlayerGame VALUES (1, 3, 2350.00);
INSERT INTO PlayerGame VALUES (2, 1, 1000.00);
INSERT INTO PlayerGame VALUES (2, 2, 0.00);
INSERT INTO PlayerGame VALUES (2, 3, 500.00);
INSERT INTO PlayerGame VALUES (3, 2, 0.00);
INSERT INTO PlayerGame VALUES (3, 3, 5500.00);
-- Sample records for the Property table.
INSERT INTO Property (ID, name, color, cost, rent, house_cost, hotel_cost) VALUES 
(1, 'Baltic Avenue', 'Purple', 60.00, 2.00, 50.00, 50.00),
(2, 'Boardwalk', 'Dark Blue', 400.00, 50.00, 200.00, 200.00);
-- Sample record for a player owning a property.
UPDATE Property SET ownerID = 1, houses = 2 WHERE ID = 1; -- Player 1 owns Baltic Avenue with 2 houses.
