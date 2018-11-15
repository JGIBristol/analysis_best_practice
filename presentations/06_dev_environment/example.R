# Create data -------------------------------------------------------------

# Show tab complete
# Show 'Go to function definition'
x <- rnorm(n = 30)
y <- 3 + 2*x

# Show Rename in Scope
plot(x, y)

# Show autocomment 
# Show autoformat
newvar<-rbeta(n=10, shape1=1, shape2=2)
newy<-newvar*3

# Show indent
for(i in 1:10){
this <- i*2
is <-this + 3
horribly <- is/2
formatted <- horribly^2
print(formatted)
}
