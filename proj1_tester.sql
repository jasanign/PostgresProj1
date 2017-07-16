-- use the psql command
-- \i proj1_tester.sql
-- to load and run this batch file

-- Proj 1: Tester
-- Use the nba database. The expected results are only for the
-- database instance provided. Other database instances with
-- different results may be in evaluating the correctness of 
-- @author by Gajjan Jasani
-- @version 10 February 2017

\echo 'Problem 1: Find the names of the teams that have had at least one player be a member who also went to college at WCU.'

\echo '\nResult should be:\ntname\nTimberwolves\nRockets\nThunder\nKings\n'

select	tname
from	player as p, hasPlayedFor as hpf
where	p.college = 'WCU' and p.pname = hpf.pname;

\echo 'Problem 2: Find the name of each player who has been a member of at least three teams.'

\echo 'Result should be:\npname\nRedick\nIguodala\nMalone\nMartin\n'


with t1 (pname, numOfTeams) as (
	select	pname, count(*) as numOfTeams
	from	hasPlayedFor
	group by pname
)
select	pname
from	t1
where	numOfTeams >= 3;


\echo 'Problem 3: Find the average number of players who have played for a team. This query is asking for one number  that is the average over all of the teams of the number of players that have played for that team.'

\echo 'Result should be:\naverage_number_players\n1.60000\n'

with t1 (tname, numOfPlayers) as (
	select	tname, count(*) as numOfPlayers
	from	hasPlayedFor
	group by tname
)
select	avg(numOfPlayers) as average_number_players
from	t1;

\echo 'Problem 4:Find the names of the players who played the SmallForward position but did not play for the Spurs.'

\echo 'Result should be:\npname\nIguodala\n'

(select	pname
from	player
where	position = 'SmallForward')
except
(select	pname
from	hasPlayedFor
where	tname = 'Spurs');

\echo 'Problem 5: Find the colleges of the players who have played for both the team named the 'Spurs' and the team named 'Bucks'.'

\echo 'Result should be:\ncollege\nMaryland\n'

with t1 (pname) as (
	(select	pname
	from	hasPlayedFor
	where	tname = 'Spurs')
	intersect
	(select	pname
	from	hasPlayedFor
	where	tname = 'Bucks')
)
select	college
from	t1 join player using (pname);


\echo 'Problem 6: Find the colleges which have had either players who have played for the 'Hornets' or who play the 'Center' position.'

\echo 'Result should be:\ncollege\nWisconsin\nWakeForest\nMaryland\n'

select	distinct college
from	player join hasPlayedFor using (pname)
where	position = 'Center' or tname = 'Hornets';

\echo 'Problem 7: Find the position which the largest number of players play. If one than one position is tied for the largest numbers of players, then all the tied positions are in the result table.'

\echo 'Result should be:\nposition\nSG\n'

with t1(position, timesUsed) as (
	select	position, count(*) as timesUsed
	from	player
	group by position
),
t2 (maxTimesUsed) as (
	select	max(timesUsed) as maxTimesUsed
	from	t1
)
select	position
from	t1, t2
where	t1.timesUsed = t2.maxTimesUsed;

\echo 'Problem 8: Find the cities of the teams that the player named “Leonard” has played for.'

\echo 'Result should be:\ncity\nSanAntonio\n'

select	city
from	team as t, hasPlayedFor as hpf
where	hpf.pname = 'Leonard' and t.tname = hpf.tname;

\echo 'Problem 9: Find the college that has had the most players who have played the 'Point Guard' position who have played for at least one team. Note that a player is listed in the players relation does not imply that the have played for any teams.'

\echo 'Result should be:\ncollege\nWakeForest\n'

with t1(college, numOfPGuardPlayers) as (
	select	college, count (*) as numOfPGuardPlayers
	from	player join hasPlayedFor using (pname)
	where	position = 'PointGuard'
	group by college
),
t2 (maxNumOfPGuardPlayers) as (
	select max(numOfPGuardPlayers) as maxNumOfPGuardPlayers
	from	t1
)
select	college
from	t1, t2
where	t1.numOfPGuardPlayers = t2.maxNumOfPGuardPlayers;

\echo 'Problem 10: Find the names of the players who have not played for any team. Note that a player is listed in the players relation does not imply that the have played for any teams.'

\echo 'Result should be:\npname\nSmith\n'

(select	pname
from	player)
except
(select	pname
from	hasPlayedFor);

\echo 'Problem 11: Find the names of the players taller than every player who went to college at WCU.'

\echo 'Result should be:\npname\nDuncan\nParker\nKaminsky\nMalone\nSmith\n'

with t1(pname, height) as (
	select	pname, height
	from	player join hasPlayedFor using (pname)
	where	college = 'WCU'
),
t2 (maxWCU_Height) as (
	select	max(height) as maxWCU_Height
	from	t1
)
select	pname
from	t2, player
where	player.height > t2.maxWCU_Height;
