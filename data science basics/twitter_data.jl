 # add twitter with the package manager 

using Twitter, Test
using JSON, OAuth
using UnicodePlots

twitterauth(ENV["CONSUMER_KEY"], ENV["CONSUMER_SECRET"], ENV["ACCESS_TOKEN"], ENV["ACCESS_TOKEN_SECRET"])

# Get your mentions 
mentions_timeline_default = get_mentions_timeline()
tw = mentions_timeline_default[1]
tw_df = DataFrame(mentions_timeline_default)

# Search for tweets of interest - mentions ukraine and has at least 10000 retweets 
ukraine_tweets = get_search_tweets(q = "Ukraine min_retweets:10000", count = 5)

# Get a followers list 
followers = get_followers_ids(screen_name = "twitter", count = 10_000)

# get a very long friends list - like this person who follows lots of people
friends = get_friends_ids(screen_name = "BarackObama", count = 10_000)

# Now, run a slightly more complicated query 
# extended mode provides the full tweet text 
# typed_query allows the operators OR to work as expected 
ju_py_r = get_search_tweets(q = "python OR rstats OR julialang OR javascript", src="typed_query", tweet_mode="extended", count = 5000)

# how many statuses did I get? 
std_tweets = [x.full_text for x in ju_py_r["statuses"] if !contains(x.full_text, r"^RT")]
get_rt_status(x) = x.retweeted_status["full_text"]
rt_tweets = [get_rt_status(x) for x in ju_py_r["statuses"] if contains(x.full_text, r"^RT")]
alltweets = [std_tweets; rt_tweets]
# now join both types of tweets together, count the numbers of each reference 
tots = Dict()
[tots[lang] = 0 for lang in ["python", "rstats", "javascript", "julialang"]]
for codinglang in ["python", "rstats", "javascript", "julialang"]
    tot = length(findall(contains.(alltweets, "$codinglang")))
    tots[codinglang] += tot
    println(tot)
end
# Unicode plot 
barplot(string.(collect(keys(tots))), Int64.(collect(values(tots))))

# let's ensure the query worked as expected
sum(contains([contains(x.text, r"python|rstats|julialang|javascript") for x in ju_py_r["statuses"]])

# There is a lot of data just in the Twitter data 
# for example, you can get a user descriptions
ju_py_r["statuses"][4].user["description"]