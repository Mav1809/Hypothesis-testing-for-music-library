SELECT
	test.Test_Name_of_artist,
	test.ArtistId AS ArtistId,
	High_or_Low,
	COUNT(High_or_Low) AS Number_of_tracks,
	SUM(Tracks_ordered_binary) AS Tracks_ordered
FROM 
(SELECT
	Artists_.Test_Name_of_artist AS Test_Name_of_artist,
	Artists_.ArtistId,
	Artists_.TrackId,
	High_or_Low,
	MAX(CASE WHEN Artists_.TrackId=invoice_items.TrackId THEN 1 ELSE 0 END) AS Tracks_ordered_binary
	
FROM
(SELECT 
	artists.Name AS Test_Name_of_artist,
	Artists.ArtistId AS ArtistId,
	artists.ArtistId AS ArtistId,
	High_or_Low,
	albums.TrackId AS TrackId
FROM
(SELECT
	albums.ArtistId,
	Duration.Name,
	Duration.TrackId AS TrackId,
	High_or_Low
FROM 
(SELECT 
	AlbumId,
	Name,
	TrackId,
	MAX(CASE WHEN Milliseconds<393599.212103911 THEN 1 ELSE 0 END) AS High_or_Low
FROM tracks 
GROUP BY
  TrackId) Duration
INNER JOIN
	albums
ON
	Duration.AlbumId=albums.AlbumId
GROUP by
	albums.Title,
	Duration.TrackId
) albums
INNER JOIN
	(SELECT *
	FROM artists
	WHERE ArtistId=22
	)Artists
ON
	albums.ArtistId=Artists.ArtistId
GROUP BY
	Artists.Name,
	albums.TrackId) Artists_
LEFT JOIN 
	invoice_items
ON 
	Artists_.TrackId=invoice_items.TrackId
GROUP BY
	Artists_.TrackId) test
GROUP BY
	High_or_Low