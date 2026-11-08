# spotify_analysis.sql
Exploratory data analysis of Spotify tracks and audio metrics using MySQL, featuring advanced window functions, CTEs, and streaming performance analytics.
# Spotify Tracks & Audio Features SQL Data Analysis Project

## Project Overview
This project performs an exploratory data analysis of Spotify tracks and multimedia audio features using MySQL. It utilizes advanced SQL querying patterns—including Common Table Expressions (CTEs), window functions (`DENSE_RANK()`), rolling frame aggregations (`UNBOUNDED PRECEDING`), and conditional case logic—to derive deep insights into track streaming performance, audio metrics (energy, liveness, danceability), and platform engagement.

---

## Database & Schema Structure
* **Database Name:** `spotify_db`
* **Primary Table:** `spotify`
* **Key Attributes Analyzed:** `artist`, `track`, `album`, `album_type`, audio metrics (`danceability`, `energy`, `loudness`, `speechiness`, `acousticness`, `instrumentalness`, `liveness`, `valence`, `tempo`), platform metrics (`views`, `likes`, `comments`, `stream`, `most_playedon`), and status flags (`licensed`, `official_video`).

---

## Key Business & Analytical Questions Addressed
1. **High-Performance Streaming:** Filtering tracks with massive streaming metrics (> 1 billion streams).
2. **Platform Engagement:** Auditing comments on licensed tracks and validating official video metrics against user views and likes.
3. **Audio Feature Analytics:** Finding top energy tracks, calculating max-min energy variance per artist, and evaluating liveness against dataset averages.
4. **Window Ranking & Partitioning:** Isolating the **Top 3 most viewed tracks per artist** using `DENSE_RANK()` partitioned across artists.
5. **Platform Preference Auditing:** Using conditional case statements and `HAVING` clauses to identify artists whose tracks are played more on YouTube than Spotify.
6. **Rolling Calculations:** Computing moving/rolling averages of streams per artist ordered by track name using advanced window framing (`UNBOUNDED PRECEDING AND CURRENT ROW`).
7. **Metric Categorization:** Segmenting tracks into 'High', 'Medium', and 'Low' danceability tiers using `CASE` logic.

---

## Repository Structure
```text
├── spotify_analysis.sql     # Complete DDL, database initialization, and analytical SQL queries
└── README.md                # Project documentation and summary overview
