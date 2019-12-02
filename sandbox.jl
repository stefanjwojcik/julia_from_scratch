

using Twitter

twitterauth(ENV["CONSUMER_KEY"],ENV["CONSUMER_SECRET"],ENV["ACCESS_TOKEN"],ENV["ACCESS_TOKEN_SECRET"])

mentions_timeline_default = get_mentions_timeline()
tw = mentions_timeline_default[1]
tw_df = DataFrame(mentions_timeline_default)
@test 0 <= length(mentions_timeline_default) <= 20
@test typeof(mentions_timeline_default) == Vector{Tweets}
@test typeof(tw) == Tweets
@test size(tw_df)[2] == 30


user_timeline_default = get_user_timeline(screen_name = "randyzwitch")

frs = get_friends_ids(screen_name = "randyzwitch")

fols = get_followers_ids(screen_name = "randyzwitch")

# can only get 5K at a time
fols = get_followers_ids(screen_name = "jack")
fols2 = get_followers_ids(screen_name = "jack", next_cursor = 1651244536622177747)
