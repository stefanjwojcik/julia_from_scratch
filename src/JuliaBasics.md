# How to Julia 


Julia is fairly simple to learn, and if you're familiar with other programming languages, its syntax will look familiar. However, Julia has some interesting features that allow it to run extremely fast. In fact, this is the reason that Julia is a contender for doing computation in the Digtal Age. It combines its simple readability with extraordinary performance. 

## A big calculator 

```julia
1 + 1 
```

But julia supports an extensive arrange of characters, allowing you to define mathematical statements. 
```julia
1/π 
```

Not only that, but functions can contain such mathematical symbols. 

```julia 
β(X, Y) = inv(X'*X)*X'*Y
n, p = 1000, 5
X = rand(n, p)
randbeta = rand(p)
Y = X * randbeta + randn(n)
β(X, Y) - randbeta 
```

```julia
function func(x)
    print("hi")
end
```
