-- spotify project 
-- creating my database 
CREATE DATABASE IF NOT EXISTS spotify_db;

use spotify_db;

CREATE TABLE spotify ( artist VARCHAR(255), track VARCHAR(255), 
album VARCHAR(255), album_type VARCHAR(50), danceability FLOAT, 
energy FLOAT, loudness FLOAT, speechiness FLOAT, acousticness FLOAT, 
instrumentalness FLOAT, liveness FLOAT, valence FLOAT, tempo FLOAT, 
duration_min FLOAT, title VARCHAR(255), channel VARCHAR(255),
 views BIGINT, likes BIGINT, 
 comments BIGINT, 
 licensed VARCHAR(10),
 official_video VARCHAR(10), 
stream BIGINT, energy_liveness FLOAT, most_playedon VARCHAR(50) );


-- checking my table 

select count(*) from spotify;

select * from spotify 
limit 25;

-- Retrieve all tracks with more than 1 billion streams.
select * from spotify 
where stream>='1000000000'
order by stream desc ;


select distinct album,artist from spotify;



-- Get the total number of comments for tracks where licensed = 'TRUE'. 
select sum(comments) as total_licensed_comments
from spotify where licensed= 'TRUE';


-- Find all tracks where album_type is 'single'.

select * from spotify 
where album_type = 'single';

-- count artist
select artist ,count(*) as num_of_tracks 
from spotify group by artist;

-- Calculate the average danceability of tracks in each album.
select album,track,avg(danceability) from spotify 
group by album,track;


-- Find the top 5 tracks with the highest energy.

select track,energy 
from spotify order by energy desc
limit 5;


with cte_rank as 
(select * , dense_rank() over (order by energy desc) as my_rank from spotify)

select track from cte_rank limit 5;


-- List tracks where views > likes and official_video = 'TRUE'.
select * from spotify 
where views > likes and official_video='True' ;


-- Find tracks where liveness is above the average liveness.
select avg(liveness) from spotify;

select * from spotify where liveness>(select avg(liveness) from spotify);

-- Calculate the difference between highest and lowest energy for each artist.
select artist ,max(energy) -min(energy) as diff 
from spotify group by artist;


-- Find tracks where energy_liveness > 1.2.

select track from spotify where energy_liveness>'1.2';


-- Top 3 most viewed tracks for each artist using DENSE_RANK().

with top_three as (select*,
 dense_rank() over (partition by artist order by views desc) as my_rank from spotify)
 select artist,track from top_three where my_rank<=3;
 
 
 -- Find artists whose tracks are played more on YouTube than Spotify. 
 with play_cte as (select *,
(case when most_playedon ='Youtube' then 1 else 0 end) as Youtube ,
( case when most_playedon ='Spotify' then 1 else 0 end) as Spotify
from spotify)

select artist ,sum(Youtube),Sum(Spotify)
from play_cte group by artist 
having sum(Youtube)>sum(Spotify);



use spotify_db;

-- Calculate the rolling average of streams per artist ordered by track name.


select *, 
avg(stream) over (partition by artist order by track
 rows between unbounded preceding and current row)as rolling_average
 from spotify;
 
 
 -- Categorize tracks by danceability ('High', 'Medium', 'Low') and count totals.
 with my_cte as (select danceability,
 (case when danceability > 0.8 then 'High'
when danceability >0.5 then 'Medium' when danceability <0.5 then 'Low'
end) as dance_status from spotify)

select dance_status ,count(*) from my_cte 
group by dance_status;


