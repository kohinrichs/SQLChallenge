SELECT
    Id,
    Title,
    SongLength,
    ReleaseDate,
    GenreId,
    ArtistId,
    AlbumId
FROM Song;

-- Runs the same as above - asterisk means select all columns. Can use during development. DO NOT USE IN PRODUCTION.
SELECT * FROM Song;

SELECT
    Id,
    Title,
    ReleaseDate
FROM Song;

-- WHERE clause will filter the results
SELECT
    Id,
    Title,
    SongLength,
    ReleaseDate,
    GenreId,
    ArtistId,
    AlbumId
FROM Song
WHERE SongLength > 100;

-- Join will combine tables together into one result. Using From Song s to make set song = s
SELECT s.Title,
       a.ArtistName
  FROM Song s
       LEFT JOIN Artist a on s.ArtistId = a.id;

-- Adding new value to Genre
INSERT INTO Genre (Label) VALUES ('Techno');

SELECT * FROM Genre;

-- Change the length (in seconds) for one of the songs
select SongLength from Song where Id = 18;

-- Update the song
update Song
set SongLength = 515
where Id = 18;

-- Check to make sure the song length was updated
select SongLength from Song where Id = 18;

-- DELETE NEED WHERE
delete from Song where Id = 18;

SELECT * FROM Song;

----- Exercises -------
-- 1. Query all of the entries in the Genre table
SELECT * FROM Genre; 

-- OR

SELECT
    Id,
    Label
FROM Genre;

-- 2. Query all the entries in the Artist table and order by the artist's name. (HINT: use the ORDER BY keywords)
SELECT * FROM Artist
ORDER BY ArtistName;

-- 3. Write a SELECT query that lists all the songs in the SONG table and include the Artist name
SELECT
    s.Id,
    s.Title,
    s.SongLength,
    s.ReleaseDate,
    s.GenreId,
    s.AlbumId,
    a.ArtistName
FROM Song s
        LEFT Join Artist a on s.ArtistId = a.id;

-- 4. Write a SELECT query that lists all the Artists that have a Pop Album. (Plot Twist - there are no pop albums)
SELECT * FROM Genre;

SELECT * FROM Album;

SELECT 
    b.ArtistName,
    g.Label
FROM Album a
LEFT JOIN Artist b on a.ArtistId = b.id 
LEFT JOIN Genre g on a.GenreId = g.id
WHERE GenreId = 2;

-- Similar but less specificty about which columns are shown
SELECT *
FROM Album
LEFT JOIN Artist on Album.ArtistId = Artist.Id
LEFT JOIN Genre on Album.GenreId = Genre.Id
WHERE GenreId = 9;


-- 5. Write a SELECT query that lists all the Artists that have a Jazz or Rock Album
SELECT 
    b.ArtistName,
    g.Label
FROM Album a
LEFT JOIN Artist b on a.ArtistId = b.id 
LEFT JOIN Genre g on a.GenreId = g.id
WHERE GenreId = 2 OR GenreId = 4;

-- 6. Write a SELECT statement that lists the Albums with no songs.
SELECT *
FROM Album
WHERE 