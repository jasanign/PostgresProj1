-- Assignment Two: Copy Tables Batch
-- @author Gajjan Jasani
-- @version 27 February 2017

\echo 'Copying "player" table.....'

\copy player from 'data/player_data.txt'	
	
\echo 'Copying "team" table.....'

\copy team from 'data/team_data.txt'

\echo 'Copying "hasPlayedFor" table.....'

\copy hasPlayedFor from 'data/hasPlayedFor_data.txt'


\echo 'All the tables are populated.....'