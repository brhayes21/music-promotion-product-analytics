-- Compare reach and stream conversion by campaign type.

SELECT
  c.campaign_type,
  SUM(p.impressions) AS total_impressions,
  SUM(p.streams) AS total_streams,
  SAFE_DIVIDE(SUM(p.streams), SUM(p.impressions)) AS stream_conversion_rate
FROM `music-promotion-analytics.music_promotion_analytics.daily_performance AS p
JOIN `music-promotion-analytics.music_promotion_analytics.campaigns AS c
  ON p.campaign_id = c.campaign_id
GROUP BY c.campaign_type
ORDER BY stream_conversion_rate DESC;
