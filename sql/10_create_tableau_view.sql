-- Joined BigQuery view used as the Tableau data source.

CREATE OR REPLACE VIEW `music-promotion-analytics.music_promotion_analytics.promotion_analysis AS
SELECT
  p.event_date,
  p.campaign_id,
  c.campaign_type,
  c.objective,
  c.campaign_tier,
  c.target_market,
  p.track_id,
  t.artist_name,
  t.track_name,
  t.genre,
  t.release_stage,
  t.artist_followers,
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
  ON p.track_id = t.track_id;
