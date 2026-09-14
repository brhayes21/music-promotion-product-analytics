-- Verify row counts after loading the three synthetic source tables.

SELECT 'tracks' AS table_name, COUNT(*) AS row_count
FROM `music-promotion-analytics.music_promotion_analytics.tracks
UNION ALL
SELECT 'campaigns', COUNT(*)
FROM `music-promotion-analytics.music_promotion_analytics.campaigns
UNION ALL
SELECT 'daily_performance', COUNT(*)
FROM `music-promotion-analytics.music_promotion_analytics.daily_performance;
