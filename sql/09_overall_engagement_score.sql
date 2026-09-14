-- Relative campaign score using percentile-rank window functions.
-- The five components are equally weighted as a transparent modeling choice.

WITH campaign_metrics AS (
  SELECT
    p.campaign_id,
    c.campaign_type,
    t.artist_name,
    t.track_name,
    SUM(p.impressions) AS total_impressions,
    SUM(p.streams) AS total_streams,
    SAFE_DIVIDE(SUM(p.streams), SUM(p.impressions)) AS stream_conversion_rate,
    SAFE_DIVIDE(SUM(p.saves), SUM(p.streams)) AS save_rate,
    SAFE_DIVIDE(SUM(p.playlist_adds), SUM(p.streams)) AS playlist_add_rate,
    SAFE_DIVIDE(SUM(p.repeat_listeners), SUM(p.streams)) AS repeat_rate,
    SAFE_DIVIDE(SUM(p.skips), SUM(p.streams)) AS skip_rate
  FROM `music-promotion-analytics.music_promotion_analytics.daily_performance AS p
  JOIN `music-promotion-analytics.music_promotion_analytics.campaigns AS c
    ON p.campaign_id = c.campaign_id
  JOIN `music-promotion-analytics.music_promotion_analytics.tracks AS t
    ON p.track_id = t.track_id
  GROUP BY p.campaign_id, c.campaign_type, t.artist_name, t.track_name
),
percentile_scores AS (
  SELECT
    *,
    PERCENT_RANK() OVER (ORDER BY stream_conversion_rate) AS conversion_score,
    PERCENT_RANK() OVER (ORDER BY save_rate) AS save_score,
    PERCENT_RANK() OVER (ORDER BY playlist_add_rate) AS playlist_score,
    PERCENT_RANK() OVER (ORDER BY repeat_rate) AS repeat_score,
    PERCENT_RANK() OVER (ORDER BY skip_rate DESC) AS low_skip_score
  FROM campaign_metrics
)
SELECT
  campaign_id,
  campaign_type,
  artist_name,
  track_name,
  ROUND(stream_conversion_rate * 100, 2) AS conversion_pct,
  ROUND(save_rate * 100, 2) AS save_pct,
  ROUND(repeat_rate * 100, 2) AS repeat_pct,
  ROUND(skip_rate * 100, 2) AS skip_pct,
  ROUND(
    (conversion_score + save_score + playlist_score + repeat_score + low_skip_score) / 5 * 100,
    1
  ) AS overall_engagement_score
FROM percentile_scores
ORDER BY overall_engagement_score DESC;
