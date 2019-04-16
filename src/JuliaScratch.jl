__precompile__()
module JuliaScratch

using LinearAlgebra
using Gadfly
using DataFrames
using ForwardDiff
using Statistics
using Distributions
using PyCall
using PyPlot
using DataStructures
using Distances
using Clustering
using Random

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
    squared_error,
    squared_log_error,
    make_iris

#Supervised_learning
include("supervised/regression.jl")

#Utility functions
include("utils/utils.jl")

end
