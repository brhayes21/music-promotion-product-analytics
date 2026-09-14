-- Join campaign performance to campaign and track metadata.

SELECT
  p.event_date,
  p.campaign_id,
  c.campaign_type,
  t.artist_name,
  t.track_name,
  t.genre,
  p.listener_segment,
  p.country,
  p.impressions,
  p.streams,
  p.saves,
  p.playlist_adds,
  p.repeat_listeners,
  p.skips
FROM `music-promotion-analytics.music_promotion_analytics.daily_performance AS p
JOIN `music-promotion-analytics.music_promotion_analytics.campaigns AS c
  ON p.campaign_id = c.campaign_id
JOIN `music-promotion-analytics.music_promotion_analytics.tracks AS t
  ON p.track_id = t.track_id
LIMIT 20;
