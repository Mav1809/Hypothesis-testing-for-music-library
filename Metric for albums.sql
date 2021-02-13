SELECT
	test.Test_Album_Title,
	test.AlbumId,
	High_or_Low,
	COUNT(High_or_Low) AS Number_of_tracks,
	SUM(Tracks_ordered_binary) AS Tracks_ordered
FROM 
(SELECT
	Test_event.Title AS Test_Album_Title,
	Test_event.AlbumId,
	Test_event.TrackId,
	Test_event.Name,
	High_or_Low,
	MAX(CASE WHEN Test_event.TrackId=invoice_items.TrackId THEN 1 ELSE 0 END) AS Tracks_ordered_binary
	
FROM
(SELECT
	albums.Title AS Title,
	Duration.Name,
	Duration.TrackId AS TrackId,
	albums.AlbumId,
	albums.ArtistId,
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
	(SELECT *
	FROM albums
	WHERE AlbumId=20) albums
ON
	Duration.AlbumId=albums.AlbumId
GROUP by
	albums.Title,
	Duration.TrackId
) Test_event
LEFT JOIN 
	invoice_items
ON 
	Test_event.TrackId=invoice_items.TrackId
GROUP BY
	Test_event.TrackId) test
GROUP BY
	High_or_Low