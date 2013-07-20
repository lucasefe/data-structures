require 'test/unit'

include Test::Unit::Assertions

def fib(n)
  return 0 if n == 0
  return 1 if n == 1
  return fib(n-1) + fib(n-2)
end

assert fib(0) == 0 
assert fib(1) == 1 
assert fib(2) == 1
assert fib(3) == 2
assert fib(4) == 3
assert fib(5) == 5
assert fib(10) == 55
assert fib(20) == 6765



