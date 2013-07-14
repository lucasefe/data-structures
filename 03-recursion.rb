
require 'test/unit'
 
include Test::Unit::Assertions

def factorial(n)
  return 0 if n < 0
  return 1 if n == 0 || n == 1
  return n * factorial(n-1)
end

assert factorial(1) == 1
assert factorial(2) == 2
assert factorial(3) == 6
assert factorial(4) == 24

