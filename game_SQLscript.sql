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