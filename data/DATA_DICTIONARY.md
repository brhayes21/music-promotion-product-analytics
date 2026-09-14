# Music Promotion Product Analytics — Data Dictionary

This is a **synthetic dataset** generated with AI assistance, created for an independent portfolio project. It is not Spotify internal data.

## tracks.csv
- track_id: synthetic track identifier
- artist_id: synthetic artist identifier
- artist_name: fictional artist name
- track_name: fictional track title
- genre: track genre
- release_stage: New Release, Recent, or Catalog
- artist_followers: synthetic artist follower count

## campaigns.csv
- campaign_id: synthetic promotion campaign identifier
- campaign_type: Discovery Mode, Marquee, or Showcase (used only as product-style labels for portfolio analysis)
- track_id: track promoted by the campaign
- start_date / end_date: campaign dates
- objective: campaign objective
- campaign_tier: Standard or Priority
- target_market: intended market

## daily_performance.csv
Each row represents one campaign-day-listener segment-country aggregate.
- event_date: date
- campaign_id: campaign identifier
- track_id: promoted track
- listener_segment: New listener, Casual listener, Existing fan, or Lapsed listener
- country: US, Canada, or Mexico
- impressions: promotional exposures
- streams: streams attributed to those exposures
- saves: streams followed by a save
- playlist_adds: streams followed by a playlist add
- repeat_listeners: listeners who returned to the track
- skips: streams that were skipped

## Suggested derived metrics
- stream_conversion_rate = streams / impressions
- save_rate = saves / streams
- playlist_add_rate = playlist_adds / streams
- repeat_rate = repeat_listeners / streams
- skip_rate = skips / streams
