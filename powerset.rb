# procedural 
def powerset(array, start = 0, set = [[]])
  current = array[start]
  start += 1
  powerset(array, start, set) if start < array.size

  (start + 1).upto(array.size) do |i|
    set.push [current, *array[(start)...i]]
  end
  set.push [current]
end

puts powerset([1,2,3,4]).sort.inspect

# inside array

class Array
  def powerset
    if empty?
      [[]]
    else
      set = self[]
    end
  end
end


puts [1,2,3,4].powerset.sort.inspect