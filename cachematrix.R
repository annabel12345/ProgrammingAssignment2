## Overall Design of makeCacheMatrix() and cacheSolve()
# The cachematrix.R contrains two functions, makeCacheMatrix and
# cacheSolve. The first function makeCacheMatrix() creates an R object
# that stores a matrix and its inverse. The second function cacheSolve
# requires an argument that is returned by makeCacheMatrix in order to 
# retrieve the inverse matrix from the cached value that is stored in 
# the makeCacheMatrix() object's environment.

## Description of the first function: makeCacheMatrix()
# The makeCacheMatrix() builds a set of functions and returns the 
# functions within a list to the parent environment. The list 
# contains a function to: 1) set a value of the matrix,
# 2) get the value of the matrix, 3) set the value of the inverse of 
# the matrix, 4) get the value of the inverse of the matrix.

makeCacheMatrix <- function(x = matrix()) {
  m <- NULL
  set <- function(y) {
          x <<- y
          m <<- NULL
  }
 get <- function() x
 setsolve <- function(solve) m <<- solve
 getsolve <- function () m
 list(set = set, get = get,
      setsolve = setsolve,
      getsolve = getsolve)
 }


## Description of the second function: cacheSolve()
#The cacheSolve function below calculates the inverse of the special 
#"matrix" created with the above function. However, it first 
#checks to see if the inverse of the matrix has already been calculated. 
#If so, it gets the inverse of the matrix from the cache and skips the 
#computation. Otherwise, it calculates the inverse of the matrix and sets 
#the value of the inverse the matrix in the cache via the setsolve function.

cacheSolve <- function(x, ...) {
  m<-x$getsolve ()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- solve (data, ...)
  x$setsolve(m)
  m
        ## Return a matrix that is the inverse of 'x'

  
  }
