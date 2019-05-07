# The purpose of this script is to do basic data scienc
# recodes, filters, mutates, and joins

using Gadfly, DataFrames, Query, CSVFiles, DataFramesMeta, Random

df = load("/users/electron/Downloads/redfin_sold_more_more.csv") |> DataFrame;


# Alter the column names - they are currently a mess
# replace the string '.' to nothing
alt_names = [Symbol(replace(String(x), "." => "")) for x in names(df)]
# And actually alter the names in place
names!(df, alt_names)

# Plot lat and long
df = df |> @mutate(location = lowercase(_.locationvalue)) |> DataFrame
samp = rand(1:nrow(df), 400)
plot(x=df.latLongvaluelatitude[samp],
    y=df.latLongvaluelongitude[samp],
    color=df.location)

# quick sidebar on regex logic here::
# Find the columns that have the underlying values
cols_of_interest = [occursin("value", String(x)) for x in alt_names]
# show me the columsn with actual data
alt_names[cols_of_interest]
# Select those that are the potentially interesting for analysis
df |> @select(:pricevalue, :sqFtvalue, :hoavalue, :timeOnRedfinvalue)

# BUT HERE IS AN EASIER WAY TO SELECT WITH REGEX!
df_small = df |> @select(endswith("value"), 1) |> DataFrame

# Keep all BUT
df_small = df_small |> @select(-:lotSizevalue, -:streetLinevalue, -::unitNumbervalue,
    -:photosvalue, -:pricePerSqFtvalue, -:mlsIdvalue) |> DataFrame

# mutate to create a log variable and lower case of locationvalue
df_small = df_small |>
    @mutate(logprice = log(_.pricevalue),
            locationvalue = lowercase(_.locationvalue)) |> DataFrame

# REMOVE MISSING values
dropmissing!(df_small)

# Can als filter rows just like dplyr
df_small |> @filter(_.hoavalue <= 500) |> DataFrame

# How to group by and aggregate
df_agg = df |>
    @groupby(_.locationvalue) |>
    @map({location=key(_), price=mean(_.pricevalue)}) |>
    @orderby_descending(_.price) |>
    DataFrame

# select certain columsn
df |> @select(:status, :endtime)

# Do both
df |> @select(:status, :endtime) |>
    @filter(_.status=="COMPLETED")


df = DataFrame(a=[1,1,2,3], b=[4,5,6,8])

df2 = df |>
    @groupby(_.a) |>
    @map({a=key(_), b=mean(_.b)}) |>
    @filter(_.b > 5) |>
    @orderby_descending(_.b) |>
    DataFrame


# Remove missing among the data
comp = completecases(df_small)
df_small = df_small[comp, :]

# PLOTTING
plot(x=df_small.pricevalue, Geom.histogram)
p = plot(x=df_small.sqFtvalue[rand(1:nrow(df_small), 500)],
y=df_small.pricevalue[rand(1:nrow(df_small), 500)], Geom.point, Geom.smooth)

# Saving plots doesn't work, you need Cairo and Fontconfig
draw(PNG("myplot.png", 3inch, 3inch), p)

df = DataFrame(a=[1,1,2,3], b=[4,5,6,8])

# USING GROUPBY
df2 = df |>
    @groupby(_.a) |>
    @map({a=key(_), b=mean(_.b)}) |>
    @filter(_.b > 5) |>
    @orderby_descending(_.b) |>
    DataFrame

# USING mutate
df = DataFrame(fruit=["Apple","Banana","Cherry"],amount=[2,6,1000],price=[1.2,2.0,0.4],isyellow=[false,true,false])

q = df |> @mutate(price = 2 * _.price + _.amount) |> DataFrame

@linq df |> mutate(price2 =  2*_.price)

# joins

df1 = DataFrame(a=[1,2,3], b=[1.,2.,3.])
df2 = DataFrame(c=[2,4,2], d=["John", "Jim","Sally"])

x = df1 |> @join(df2, _.a, _.c, {_.a, _.b, __.c, __.d}) |> DataFrame
