
struct Twitterate
           previous_cursor_str::String
           ids::Int
           total_count::nothing
           previous_cursor::Int
           next_cursor::Int
           next_cursor_str::String
       end



Base.start(iter::Twitterate) = (iter.start, 0)

function Base.next(iter::EveryNth, state)
  element, count = state
  return (element, (element + iter.n, count + 1))
end

function Base.done(iter::EveryNth, state)
          _, count = state
          return count >= iter.length
      end

Base.length(iter::EveryNth) = iter.length

Base.eltype(iter::EveryNth) = Int


##############

struct EveryNth
   n::Int
   start::Int
   length::Int
end

struct Fibonacci{T<:Real} end
Fibonacci(d::DataType) = d<:Real ? Fibonacci{d}() : error("No Real type!")

Base.iterate(::Fibonacci{T}) where {T<:Real} = (zero(T), (one(T), one(T)))
Base.iterate(::Fibonacci{T}, state::Tuple{T, T}) where {T<:Real} = (state[1], (state[2], state[1] + state[2]))

for e in Fibonacci(Int64)
  e > 100 && break
  print(e, " ")
end

# HERE IS THE FUNCTION

frs = get_friends_ids(screen_name = "randyzwitch")

# input is a Dict{String, Any} object
struct IterTweet
    previous_cursor_str::String
    ids::Array{Any,1}
    total_count:: Any
    previous_cursor::Int
    next_cursor::Int
    next_cursor_str::String
end


Base.iterate(x::Friends)
    state = x.next_cursor
    return iterate(x, state)
end

# ORIGINL VRSION
Base.iterate(x::Friends, state)
    next_cursor = state
    if next_cursor > 0
        next_list = Friends(x. cursor=next_cursor)
    end
    if next_cursor <= 0
        return nothing # end iteration
    end
    state = next_list.next_cursor
    return x, state
end

# DEV VERSION:::

Base.iterate(x::Friends, state)
    next_cursor = state
    if next_cursor > 0
        next_list = Friends(x, cursor=next_cursor)
        next = get_friends_ids(screen_name = "randyzwitch", cursor = next_cursor)
    end
    if next_cursor <= 0
        return nothing # end iteration
    end
    state = next_list.next_cursor
    return x, state
end

# write a function that takes a function, can extract the arguments from it
# just write a fucking function that will do it
# get_followers_ids(screen_name = "jack", next_cursor = 1651244536622177747)
# :(get_followers_ids(screen_name="jack", next_cursor=1651244536622177747))
func = "get_friends_ids"
screen_name="jack"
next_cursor=1651244536622177747
options["screen_name"] = "jack"
options["next_cursor"] = 1651244536622177747

@generated function square(x)
    println(x)
    :(x * x)
end



function cursor(func; kwargs...)
    options = Dict{String, Any}()
    for arg in kwargs
        options[string(arg[1])] = string(arg[2])
    end

    r = ($func)(options)

    println(r)
end

function otherfunk(;kwargs...)
    for kwarg in kwargs
        println(kwarg[1])
    end
end

function my_func(args... ; kwargs...)
    if "get_friends_ids" in args
        get_friends_ids(;kwargs...)
    elseif "get_followers_ids" in args
        get_followers_ids(;kwargs...)
    else return nothing
    end
end

thisfunk = "get_friends_ids"

# THIS function can call functions with arbitrary arguments
macro callfunc(f, kwargs...)
    x = [esc(a) for a in kwargs]
    return :($(f)(; $(x...)))
end

name = "jack"
crsr = 1651244536622177747
funk = :get_friends_ids
@callfunc eval(funk) screen_name = name cursor = crsr

# while cursor
crsr = 1
while cursor >= 0
    next = @callfunc eval(funk) screen_name = name cursor = crsr
    crsr = next.cursor


function countdown(n)
    while n > 0
        print(n, " ")
        n = n - 1
    end
    println("Blastoff!")
end
