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
SELECT DISTINCT
    al.Id,
    al.Title
FROM Album al
LEFT JOIN Song s ON al.Id = s.AlbumId
WHERE s.AlbumId IS NULL
ORDER BY Title;

-- SAME AS ABOVE BUT ALSO INCLUDES A COLUMN WITH the ALBUMID
SELECT DISTINCT
    al.Id,
    al.Title,
    s.AlbumId
FROM Album al
LEFT JOIN Song s ON al.Id = s.AlbumId;

SELECT Title 
FROM Album
WHERE AlbumLength IS NULL;

-- 7. Using the INSERT statement, add one of your favorite artists to the ARTIST table.
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('Beyonce', 2003); 

INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('Adele', 2011);


delete from Artist where Id = 1004;

SELECT *
FROM Artist;

--8. Using INSERT statement, add one or more albums by your Artist to the ALBUM table

SELECT 
    a.ArtistName,
    a.Id
FROM Artist a
WHERE a.ArtistName = 'Beyonce'
INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('Lemonade', '11/14/2016', 2268, 'Def Jam', 1005, 6);

--Check to see that the album was added
SELECT *
FROM Album
WHERE ArtistId = 1005;

delete from Album where Id = 1002;

--9. Using the INSERT statement, add some songs that are on the album to the Song table.
SELECT
    al.Title,
    al.Id
FROM Album al
WHERE al.ArtistId = 1002
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('Hold Up', 354, '11/14/2016', 6, 1005, 1003);

SELECT *
FROM Song
WHERE ArtistId = 1005

delete from Song where Id = 1002;

/* 10. Write a SELECT query that provides the song titles, album title, and artist name for all of the data you just entered in. Use the LEFT JOIN keyword sequence to connect the tables, and the WHERE keyword to filter the results to the album and artist you added.

Reminder: Direction of join matters. Try the following statements and see the difference in results.

SELECT a.Title, s.Title FROM Album a LEFT JOIN Song s ON s.AlbumId = a.Id;
SELECT a.Title, s.Title FROM Song s LEFT JOIN Album a ON s.AlbumId = a.Id; */
SELECT
    s.Title as SongTitle,
    al.Title as AlbumTitle,
    ar.ArtistName
    from Song s
    JOIN Album al on s.AlbumId = al.id
    JOIN Artist ar on s.ArtistId = ar.id
WHERE s.Title = 'TV Party'
    OR s.Title = 'Thug'
    OR ar.ArtistName = 'Beatles';

--11. Write a SELECT statement to display how many songs exist for each album. You'll nee to use the COUNT() function and the GROUP BY keyword sequence.

SELECT count(s.id) as SongCount, al.Title, ar.ArtistName
    FROM Song s
    LEFT JOIN Album al on s.AlbumId = al.Id
    LEFT JOIN Artist ar on al.ArtistID = ar.Id
GROUP BY al.Title, ar.ArtistName


--12. Write a SELECT statement to display how many songs exist for each artist. You'll need to use the COUNT() function and the GROUP BY keyword sequence.
SELECT count(s.id) as SongCount, ar.ArtistName
    FROM Song s
    LEFT JOIN Artist ar on s.ArtistId = ar.Id
GROUP BY ar.ArtistName;


--13. Write a SELECT statement to display how many songs exist for each genre. You'll need to use the COUNT() function and the GROUP BY keyword sequence 
-- Only lists Genres with songs associated with them
SELECT count(s.id) as SongCount, g.Label
FROM Song s
LEFT JOIN Genre g on s.GenreId = g.Id
GROUP BY g.Label;

-- OR to list all of the genres
SELECT count(s.id) as SongCount, g.Label
FROM Genre g
LEFT JOIN Song s on g.Id = s.GenreId
GROUP By g.Label;

--14. We want a count of the distinct number of labels for each artist
SELECT count(distinct al.label) as NumberOfLabels, ar.ArtistName
    FROM Artist ar JOIN Album al on ar.id = al.ArtistId
GROUP BY ar.ArtistName
    HAVING count(distinct al.label) > 1


--15. Using MAX() function, write a select statement to find the album with the longest duration. The result should display the album title and the duration.
SELECT a.Title, a.AlbumLength
FROM Album a
WHERE a.AlbumLength = (
    SELECT max(a.AlbumLength)
    FROM Album a
);

--OR Order by desending (greatest to least)

SELECT TOP 1 a.Title, a.AlbumLength
FROM Album a
ORDER BY a.AlbumLength desc;

--16. Wrapped in parens so it knows to run sub-select first

SELECT s.Title, s.SongLength
    FROM Song s
 WHERE s.SongLength = (
    SELECT max(s.SongLength)
    FROM Song s
);

--OR Order by desending (greatest to least)

SELECT TOP 1 s.Title, s.SongLength
FROM Song s
ORDER BY s.SongLength desc;


--17. Modify the previous query to also display the title of the album.
SELECT TOP 1 s.Title as SongTitle, s.SongLength, a.Title as AlbumTitle
FROM Song s
LEFT JOIN Album a on s.AlbumId = a.Id
ORDER BY s.SongLength desc;