# package for statistical distributions
using Distributions
# initializing pseudorandom number generation
srand(123)

# hidden coefficient of a linear model: y = mx + q
m = 3.0
q = 7.0
samples = 100
error_sigma = 0.5

# explanatory variable X
x = Uniform(0.0, 1000.0)
# there will be some error in measuring it, normally distributed
e = Normal(0.0, error_sigma)
# real values for X
x_latent = rand(x, samples)
# observed values, affected by noise
x_observed = x_latent + rand(e, samples)

# real values for X generated by the latent process
y_latent = x_latent * m + q
# observed values, affected by noise
y_observed = y_latent + rand(e, samples)

# the data available to us
println("x_observed:")
println(repr(x_observed))
println("y_observed:")
println(repr(y_observed))

# (ordinary) least squares estimation
# matrix with 2 columns: x_observed and (1, 1, 1, ...) for q estimation
X = [x_observed ones(length(x_observed))]
pseudoinverse = inv(X'*X)*X'
parameters = pseudoinverse*y_observed

println("actual parameters:")
println(m, ", ", q)
println("estimated parameters:")
println(repr(parameters))
