CREATE TABLE scuttle_building ( 
  id INTEGER PRIMARY KEY,
  a_title VARCHAR (255) NOT NULL,
  a_street_address VARCHAR (255) NOT NULL
); 

CREATE TABLE scuttle_building_floor ( 
  id INTEGER PRIMARY KEY,
  f_building INTEGER NOT NULL,
  a_title VARCHAR (255) NOT NULL
); 

CREATE TABLE scuttle_room ( 
  id INTEGER PRIMARY KEY,
  f_building_floor INTEGER NOT NULL,
  a_title VARCHAR (255) NOT NULL,
  a_key VARCHAR (255) NOT NULL,
  a_x INTEGER NOT NULL,
  a_y INTEGER NOT NULL,
  a_width INTEGER NOT NULL,
  a_height INTEGER NOT NULL
); 

CREATE TABLE scuttle_room_thingie ( 
  id INTEGER PRIMARY KEY,
  f_building_floor INTEGER NOT NULL,
  a_title VARCHAR (255) NOT NULL,
  a_key VARCHAR (255) NOT NULL,
  a_x INTEGER NOT NULL,
  a_y INTEGER NOT NULL,
  a_width INTEGER NOT NULL,
  a_height INTEGER NOT NULL
); 

CREATE TABLE scuttle_room_feature ( 
  id INTEGER PRIMARY KEY,
  a_title VARCHAR (255) NOT NULL
); 

CREATE TABLE scuttle_room_has_feature ( 
  id INTEGER PRIMARY KEY,
  f_room INTEGER NOT NULL,
  f_feature INTEGER NOT NULL,
  a_quantity INTEGER NOT NULL,
  UNIQUE KEY (f_room, f_feature),
  INDEX (f_feature)
); 

CREATE TABLE scuttle_day ( 
  id INTEGER PRIMARY KEY,
  a_title VARCHAR (255) NOT NULL
); 

CREATE TABLE scuttle_timeslot ( 
  id INTEGER PRIMARY KEY,
  a_title VARCHAR (255) NOT NULL
); 

CREATE TABLE scuttle_reservation ( 
  id INTEGER PRIMARY KEY,
  f_room INTEGER NOT NULL,
  f_time INTEGER NOT NULL,
  UNIQUE KEY (f_room, f_time)
); 

CREATE TABLE scuttle_preliminary_reservation ( 
  id INTEGER PRIMARY KEY,
  f_room INTEGER NOT NULL,
  f_time INTEGER NOT NULL,
  f_owner INTEGER NOT NULL,
  UNIQUE KEY (f_room, f_time)
); 

CREATE TABLE scuttle_reservation_wish ( 
  id INTEGER PRIMARY KEY,
  f_room INTEGER NOT NULL,
  f_time INTEGER NOT NULL,
  f_owner INTEGER NOT NULL,
  UNIQUE KEY (f_room, f_time, f_owner),
  UNIQUE KEY (f_time, f_owner)
); 

CREATE TABLE scuttle_person ( 
  id INTEGER PRIMARY KEY,
  a_first_name VARCHAR (255) NOT NULL,
  a_last_name VARCHAR (255) NOT NULL,
  a_display_name VARCHAR (255) NOT NULL
); 

ALTER TABLE scuttle_building_floor ADD FOREIGN KEY (f_building) REFERENCES scuttle_building (id);
ALTER TABLE scuttle_room ADD FOREIGN KEY (f_building_floor) REFERENCES scuttle_building_floor (id);
ALTER TABLE scuttle_room_thingie ADD FOREIGN KEY (f_building_floor) REFERENCES scuttle_building_floor (id);
ALTER TABLE scuttle_room_has_feature ADD FOREIGN KEY (f_room) REFERENCES scuttle_room (id);
ALTER TABLE scuttle_room_has_feature ADD FOREIGN KEY (f_feature) REFERENCES scuttle_room_feature (id);
ALTER TABLE scuttle_reservation ADD FOREIGN KEY (f_room) REFERENCES scuttle_room (id);
ALTER TABLE scuttle_reservation ADD FOREIGN KEY (f_time) REFERENCES scuttle_timeslot (id);
ALTER TABLE scuttle_preliminary_reservation ADD FOREIGN KEY (f_room) REFERENCES scuttle_room (id);
ALTER TABLE scuttle_preliminary_reservation ADD FOREIGN KEY (f_time) REFERENCES scuttle_timeslot (id);
ALTER TABLE scuttle_preliminary_reservation ADD FOREIGN KEY (f_owner) REFERENCES scuttle_person (id);
ALTER TABLE scuttle_reservation_wish ADD FOREIGN KEY (f_room) REFERENCES scuttle_room (id);
ALTER TABLE scuttle_reservation_wish ADD FOREIGN KEY (f_time) REFERENCES scuttle_timeslot (id);
ALTER TABLE scuttle_reservation_wish ADD FOREIGN KEY (f_owner) REFERENCES scuttle_person (id);
