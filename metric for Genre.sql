SELECT
	test.Test_Genre_Name,
	High_or_Low,
	COUNT(High_or_Low) AS Number_of_tracks,
	SUM(Tracks_ordered_binary) AS Tracks_ordered
FROM 
(SELECT
	Test_event.Genre AS Test_Genre_Name,
	Test_event.TrackId,
	Test_event.GenreId AS Test_GenreId,
	High_or_Low,
	MAX(CASE WHEN Test_event.TrackId=invoice_items.TrackId THEN 1 ELSE 0 END) AS Tracks_ordered_binary
	
FROM
(SELECT
	genres.Name AS Genre,
	genres.GenreId AS GenreId,
	Duration.Name,
	Duration.TrackId AS TrackId,
	High_or_Low
FROM 
(SELECT 
	GenreId,
	Name,
	TrackId,
	MAX(CASE WHEN Milliseconds<393599.212103911 THEN 1 ELSE 0 END) AS High_or_Low
FROM tracks 
GROUP BY
  TrackId) Duration
INNER JOIN
	(SELECT *
	FROM genres
	WHERE GenreId=3
	) genres
ON
	Duration.GenreId=genres.GenreId
GROUP by
	genres.Name,
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