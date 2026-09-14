-- Flag campaigns with above-average reach but below-average conversion.

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
    SAFE_DIVIDE(SUM(p.repeat_listeners), SUM(p.streams)) AS repeat_rate,
    SAFE_DIVIDE(SUM(p.skips), SUM(p.streams)) AS skip_rate
  FROM `music-promotion-analytics.music_promotion_analytics.daily_performance AS p
  JOIN `music-promotion-analytics.music_promotion_analytics.campaigns AS c
    ON p.campaign_id = c.campaign_id
  JOIN `music-promotion-analytics.music_promotion_analytics.tracks AS t
    ON p.track_id = t.track_id
  GROUP BY p.campaign_id, c.campaign_type, t.artist_name, t.track_name
),
benchmarks AS (
  SELECT
    AVG(total_impressions) AS avg_impressions,
    AVG(stream_conversion_rate) AS avg_conversion_rate
  FROM campaign_metrics
)
SELECT
  cm.*,
  CASE
    WHEN cm.total_impressions > b.avg_impressions
      AND cm.stream_conversion_rate < b.avg_conversion_rate
    THEN 'High Reach / Low Conversion'
    ELSE 'Other'
  END AS performance_flag
FROM campaign_metrics AS cm
CROSS JOIN benchmarks AS b
ORDER BY total_impressions DESC;
