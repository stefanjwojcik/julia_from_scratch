# The purpose of this script is to do basic data scienc
# recodes, filters, mutates, and joins

using Gadfly, DataFrames, Query, CSVFiles

df = load("/users/electron/Downloads/redfin_sold_more_more.csv", quotechar='\.') |> DataFrame

# How to filter
df |> @filter(_.status=="Completed")

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


# Alter the column names
# replace the string '.' to nothing
# This package has some pretty cool functions
using DataFramesMeta # for dplyr-like filtering
using Random # for random sampling

alt_names = [Symbol(replace(String(x), "." => "")) for x in names(df)]
names!(df, alt_names)

@linq df_small = df |> select(:pricevalue, :sqFtvalue)

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
