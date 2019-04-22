__precompile__()
module jfs

using
    LinearAlgebra,
    Plots,
    Gadfly,
    ForwardDiff,
    Statistics,
    Distributions,
    PyCall,
    Distances,
    Random

@pyimport sklearn.datasets as dat

export
    cost_linear,
    add_reg,
    LinearRegression,
    test_LinearRegression,
    # utility functions
    make_cla,
    make_reg,
    onehot,
    softmax,
    calc_variance,
    get_random_subsets,
    train_test_split,
    calc_entropy,
    batch_iter,
    euc_dist,
    l2_dist,
    unhot,
    normalize_,
    absolute_error,
    classification_error,
    accuracy,
    mean_absolute_error,
    mean_squared_error,
    squared_error,
    squared_log_error,
    make_iris

#Supervised_learning
include("src/supervised/regression.jl")

#Utility functions
include("src/utils/utils.jl")

end
