-- Assignment Two: Create Tables Batch
-- @author Gajjan Jasani
-- @version 27 February 2017

\echo 'Creating "player" table'
create table player
	(pname varchar(20),
	college varchar(20),
	position varchar(20),
	height numeric(2,0),
	primary key(pname));
	
	
\echo 'Creating "team" table'
create table team
	(tname varchar(20),
	city varchar(15),
	primary key(tname));


\echo 'Creating "hasPlayedFor" table'
create table hasPlayedFor
	(pname varchar(20),
	tname varchar(20),
	foreign key(pname) references player,
	foreign key(tname) references team);


\echo 'All the tables are created'