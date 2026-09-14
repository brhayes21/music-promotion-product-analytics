-- Compare downstream engagement by campaign type.

SELECT
  c.campaign_type,
  SUM(p.streams) AS total_streams,
  SUM(p.saves) AS total_saves,
  SUM(p.playlist_adds) AS total_playlist_adds,
  SUM(p.repeat_listeners) AS total_repeat_listeners,
  SUM(p.skips) AS total_skips,
  SAFE_DIVIDE(SUM(p.saves), SUM(p.streams)) AS save_rate,
  SAFE_DIVIDE(SUM(p.playlist_adds), SUM(p.streams)) AS playlist_add_rate,
  SAFE_DIVIDE(SUM(p.repeat_listeners), SUM(p.streams)) AS repeat_rate,
  SAFE_DIVIDE(SUM(p.skips), SUM(p.streams)) AS skip_rate
FROM `music-promotion-analytics.music_promotion_analytics.daily_performance AS p
JOIN `music-promotion-analytics.music_promotion_analytics.campaigns AS c
  ON p.campaign_id = c.campaign_id
GROUP BY c.campaign_type
ORDER BY save_rate DESC;
