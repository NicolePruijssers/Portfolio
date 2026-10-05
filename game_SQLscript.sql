/* Note that the script is written for sqlite*/ /* generating table to resemble theoretical input from game*/

CREATE TABLE IF NOT EXISTS game_entry 
    (id varchar(256) PRIMARY KEY,
    name_person varchar(256) NOT NULL,
    age_person int NOT NULL,
    event varchar(256) NOT NULL,
    lp_change int , 
    xp_change int, 
    item varchar(256),
    item_ability varchar(256),
    item_colour varchar(256),
    item_lost boolean, 
    item_gained boolean, 
    event_location varchar(256),
    event_country varchar(256),
    event_city varchar(256));


/*For the sake of readable documentation, only three of the generated entries are shown here. 50 were used during development*/
INSERT INTO game_entry (id,
    name_person,
    age_person,
    event,
    lp_change,
    xp_change,
    item,
    item_ability,
    item_colour,
    item_lost,
    item_gained,
    event_location,
    event_country,
    event_city)
VALUES ('ge001', 'Aelira Moonwhisper', 27, 'Defeated a band of goblin raiders', 12, 18, NULL, NULL, NULL, FALSE, FALSE, 'Silverpine Road', 'Elarion', 'Moonhaven'),
       ('ge002', 'Brom Ironroot', 42, 'Discovered an ancient dwarven map', 5, 15, 'Dwarven Map', 'Reveals hidden underground passages', 'Bronze', FALSE, TRUE, 'Collapsed Mine', 'Khar-Dum', 'Stonegate'),
       ('ge003', 'Caelan Thorn', 19, 'Was cursed by a spiteful dryad', -10, 8, NULL, NULL, NULL, FALSE, FALSE, 'Whispering Grove', 'Elarion', 'Greenthorn')

/*create table dimension*/ 
CREATE TABLE IF NOT EXISTS game_entry_backup AS
SELECT * FROM game_entry;

CREATE TABLE if not exists person(
  person_key INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    age INTEGER NOT NULL,
    lp INTEGER DEFAULT 0,
    xp INTEGER DEFAULT 0,
    eliminated BOOLEAN default 0);

INSERT INTO person(name, age)
SELECT name_person,
       age_person
FROM game_entry /*Calculate lp and xp per character*/
UPDATE person AS p
SET lp =
  (SELECT COALESCE(SUM(g.lp_change), 0)
   FROM game_entry AS g
   WHERE g.name_person = p.name
     AND g.age_person = p.age),
    xp =
  (SELECT COALESCE(SUM(g.xp_change), 0)
   FROM game_entry AS g
   WHERE g.name_person = p.name
     AND g.age_person = p.age);


UPDATE person AS p
SET eliminated = 1
WHERE lp <0;

/* to transform the original table into a factless fact, the columns 
belonging to the person dimension will be exchanged for the foreign key.
Note that lp and xp do not belong to the person dimension. The lp and xp in the original table
are changes made to 'traits' inherent to the character. 
Note 2, it is assumed that the game enforces unique naming*/

ALTER TABLE game_entry
ADD column person_id integer references person(person_key);

UPDATE game_entry as g
SET person_id = (SELECT person_key FROM person as p
                  WHERE g.name_person = p.name AND
                  g.age_person = p.age);
