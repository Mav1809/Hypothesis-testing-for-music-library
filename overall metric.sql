SELECT
	test.Test_Name_of_playlist,
	High_or_Low,
	COUNT(High_or_Low) AS Number_of_tracks,
	SUM(Tracks_ordered_binary) AS Tracks_ordered
FROM 
(SELECT
	Playlist.Test_Name_of_playlist AS Test_Name_of_playlist,
	Playlist.TrackId,
	High_or_Low,
	MAX(CASE WHEN Playlist.TrackId=invoice_items.TrackId THEN 1 ELSE 0 END) AS Tracks_ordered_binary
	
FROM
(SELECT 
	playlists.Name AS Test_Name_of_playlist,
	playlists.PlaylistId AS PlaylistId,
	High_or_Low,
	playlist_tracks.TrackId AS TrackId
FROM
(SELECT
	playlist_track.PlaylistId,
	Duration.TrackId AS TrackId,
	High_or_Low
FROM 
(SELECT 
	TrackId,
	MAX(CASE WHEN Milliseconds<393599.212103911 THEN 1 ELSE 0 END) AS High_or_Low
FROM tracks 
GROUP BY
  TrackId) Duration
INNER JOIN
	playlist_track
ON
	Duration.TrackId=playlist_track.TrackId
GROUP by
	Duration.TrackId
) playlist_tracks
INNER JOIN
	(SELECT *
	FROM playlists
	WHERE PlaylistId=1
	)playlists
ON
	playlist_tracks.PlaylistId=playlists.PlaylistId
GROUP BY
	playlists.Name,
	playlist_tracks.TrackId) Playlist
LEFT JOIN 
	invoice_items
ON 
	Playlist.TrackId=invoice_items.TrackId
GROUP BY
	Playlist.TrackId) test
GROUP BY
	High_or_Low