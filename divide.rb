require 'test/unit'
 
include Test::Unit::Assertions
 
class Fixnum
  def /(divisor)
    divide(divisor)
  end
  
  def divide(by,min=nil,max=nil)
    min = 1.0 if min.nil?
    max = by.to_f if max.nil?
    
    raise "dbz" if by.zero?
 
    mid = (min.to_f+max.to_f)/2.0
    res = (by*mid).to_f
 
    return mid if res == self.to_f
 
    if res > self.to_f
      max = mid
    else
      min = mid
    end
 
    divide(by,min,max)
  end
end
 
assert_equal(2, 10.divide(5))
assert_equal(2, 10/5)
