Longley <- read.csv("Longley.csv")
View(Longley)

plot(Longley$Year, Longley$Employed)
plot(Longley$Population, Longley$Employed)
plot(Longley$Armed.Forces, Longley$Employed)
plot(Longley$Unemployed, Longley$Employed)
plot(Longley$GNP, Longley$Employed)
plot(Longley$GNP.deflator, Longley$Employed)

# Most correleted variable: GNP, Population, Year

mod <- lm(Employed ~ Year, data = Longley)
summary(mod)
plot(mod$model$Year, mod$fitted.values)  # Expect a straight line

mod <- lm(Employed ~ Population, data = Longley)
summary(mod)
plot(mod$model$Population, mod$fitted.values)  # Expect a straight line

mod <- lm(Employed ~ GNP, data = Longley)
summary(mod)
plot(mod$model$GNP, mod$fitted.values)  # Expect a straight line



# Define error function
error <- function(beta) {
  sum((x %*% beta - y)^2) # Sum of squared errors
}
# Define partials for b0 and b1
del.b0 <- function(b0, b1) {
  sum(-y + (b1*x + b0)) * (2 / length(x))
}
del.b1 <- function(b0, b1) {
  sum(x %*% (-y + (b1*x + b0))) * (2 / length(x))
}

### Set variables
y <- Longley$Employed 
x <- Longley$GNP

# Initialize parameters for algorithm
b0 <- 0
b1 <- 0
alpha = 0.0001
n.iter <- 500
error.history <- numeric(n.iter)
b0.history <- numeric(n.iter)
b1.history <- numeric(n.iter)

for (i in 1:n.iter) {
  b0.gradient <- del.b0(b0, b1)
  b1.gradient <- del.b1(b0, b1)
  
  b0 <- b0 - alpha*b0.gradient
  b1 <- b1 - alpha*b1.gradient
  beta <- as.matrix(c(b0, b1))
  
  error.history[i] <- error(beta)
  b0.history[i] <- b0
  b1.history[i] <- b1
}
# Collect results  
error.history[n.iter]
b0.history[n.iter]
b1.history[n.iter]
### GNP -- SSE:


