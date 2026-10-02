/* generating table to resemble theoretical input from game*/
create table if not exists game_entry
(id varchar(256) primary key,
  name_person varchar(256) not null,
  age_person int not null,
  event varchar(256) not null,
  lp_change int ,
  xp_change int,
  item varchar(256),
  item_ability varchar(256),
  item_colour varchar(256),
  item_lost boolean,
  item_gained boolean,
  event_location varchar(256),
  event_country varchar(256),
  event_city varchar(256))


/*For the sake of readable documentation, only three of the generated entries are shown here. 50 were used during development*/ 
INSERT INTO game_entry (
  id,
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
  event_city
  ) VALUES
('ge001', 'Aelira Moonwhisper', 27, 'Defeated a band of goblin raiders', 12, 18, NULL, NULL, NULL, FALSE, FALSE, 'Silverpine Road', 'Elarion', 'Moonhaven'),
('ge002', 'Brom Ironroot', 42, 'Discovered an ancient dwarven map', 5, 15, 'Dwarven Map', 'Reveals hidden underground passages', 'Bronze', FALSE, TRUE, 'Collapsed Mine', 'Khar-Dum', 'Stonegate'),
('ge003', 'Caelan Thorn', 19, 'Was cursed by a spiteful dryad', -10, 8, NULL, NULL, NULL, FALSE, FALSE, 'Whispering Grove', 'Elarion', 'Greenthorn')