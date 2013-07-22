require 'test/unit'
include Test::Unit::Assertions

# binary search works only on sorted data

array = [1,2,4,5,6,7,8,9].sort

def search(array, value, lower = nil, upper = nil)
  lower ||= 0
  upper ||= array.size - 1

  range = upper - lower
  return false if range.zero?

  center = (range / 2) + lower

  if array[center] == value 
    return true
  elsif array[center] > value
    return search(array, value, lower, center - 1 )
  else
    return search(array, value, center + 1, upper )
  end
end


assert search(array, 2)
assert !search(array, 3)

