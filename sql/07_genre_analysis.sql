-- Compare promotional performance by genre.

SELECT
  t.genre,
  COUNT(DISTINCT p.campaign_id) AS number_of_campaigns,
  SUM(p.impressions) AS total_impressions,
  SUM(p.streams) AS total_streams,
  SAFE_DIVIDE(SUM(p.streams), SUM(p.impressions)) AS stream_conversion_rate,
  SAFE_DIVIDE(SUM(p.saves), SUM(p.streams)) AS save_rate,
  SAFE_DIVIDE(SUM(p.playlist_adds), SUM(p.streams)) AS playlist_add_rate,
  SAFE_DIVIDE(SUM(p.repeat_listeners), SUM(p.streams)) AS repeat_rate,
  SAFE_DIVIDE(SUM(p.skips), SUM(p.streams)) AS skip_rate
FROM `music-promotion-analytics.music_promotion_analytics.daily_performance AS p
JOIN `music-promotion-analytics.music_promotion_analytics.tracks AS t
  ON p.track_id = t.track_id
GROUP BY t.genre
ORDER BY stream_conversion_rate DESC;
