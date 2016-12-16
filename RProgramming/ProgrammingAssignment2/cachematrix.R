# We need a pair of functions to const. a spetial matrix 
# this spetial matrix must be accompanied by their inverse 
# WE SUPOSSED THAN EVER EXISTED THE INVERSE



# First we implement a funtion than return an OBJECT of type LIST that containing two elements the
# firstone is the original matrix and the second one is the inverse of the firstone

# 1.  SET that set the matrix 
# 2.  GET that get the matrix 
# 3.  SETINV  that set inverse matrix
# 4.  GETINV that get the inverse matrix


makeCacheMatrix <- function(x = matrix())   # we are sure working with matrix 
{
  m <- NULL
  SET <- function(y) # we need a local function only for fix the value of our matrix :)
    {
      x <<- y
      m <<- NULL
    }
  GET <- function() x   # we need a local function for return the value of our matrix
  SETINV <- function(solve) m <<- solve # we redefined the function 'solve' as 'SETINV'
  GETINV <- function() m   # the function to print the inverse matrix
  list(set = SET, get = GET,
       setinv = SETINV,
       getinv = GETINV)   #our spetial matrix 

}


# Now we have a "spetial matrix" we can cache its inverse. 
# The function 'cacheSolve' take a object of type list (with four functions, makeCacheMatrix) how 
# argument and return its inverse


cacheSolve <- function(x) 
{
  m <- x$GETINV()
  if(!is.null(m)) 
  {
    message("Getting cached data... you save time :D") # In this case the inverse matrix had been calculated yet
    return(m)
  }
  datos <- x$GET() 
  m <- solve(data)
  x$SETINV(m)
  m
}
