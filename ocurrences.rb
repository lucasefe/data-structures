require 'test/unit'

include Test::Unit::Assertions

def occurrences(array)
  result = []
  count = 0
  array.each_with_index do |value, index|
    count += 1
    if value != array[index+1]
      result << [value, count]
      count = 0
    end
  end
  result
end

array = [1,3,5,3,2,6,1,1, 6].sort
results =  occurrences(array)
assert results == [
  [1, 3],
  [2, 1],
  [3, 2],
  [5, 1],
  [6, 2]
]



