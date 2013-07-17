# Quick sort
#
array = [23, 5, 33, 2, 34, 1, 7, 8, 6]

def qsort(array, size = nil)
  return [] if array.size == 0 # stops recursion

  size ||= array.size
  pivot = array[rand(size)]
  lower = 0, upper = size - 1
  while lower < upper
    while array[lower] < pivot
      lower += 1
    end
    while array[upper] > pivot
      upper -= 1
    end
    array[lower], array[upper] = array[upper], array[lower]
  end
  qsort(array, lower)
  qsort(array[(lower + 1)..-1], size - lower - 1)
end

puts qsort(array).inspect
