## Playing with ForwardDiff


# THE STANDARD EXAMPLE
f(x::Vector) = sum(sin, x) + prod(tan, x) * sum(sqrt, x);

# Some data, like parameters for a model
x = rand(5)

# this takes a function and some data
g = x -> ForwardDiff.gradient(f, x);

# outputs the gradient for each value
g(x)

# Make some datasets

X, x_test, Y, y_test = make_reg(n_features = 1)

model = LinearRegression(lr=0.01, max_iters=200, reg="l1", C=0.03)

n_sample = size(X,1)
n_feature = size(X,2)

model.params = randn(n_feature+1)*10
model.errors = randn(n_feature+1)*10

global X_global = hcat(X,ones(n_sample))
global y_global = Y

#
w = model.params
# For some reason this must be defined AFTER global variables defined
function cost_func(w)
    add_reg(mean_squared_error(y_global, X_global*w),w, model)
end


cost_d = x -> ForwardDiff.gradient(cost_func,x)
cost_d(model.params)

###### THIS WILL DO gradient for the linear model
function runit()
    errors_norm = 1e10
    iter_count = 0
    while errors_norm > model.tolerance && iter_count < model.max_iters
        model.params -= model.C*cost_d(model.params)
        errors_norm = cost_func(model.params)
        println("Epoch: $(iter_count): current errors norm is $(errors_norm)")
        iter_count = iter_count + 1
        end
    return model.params
end
