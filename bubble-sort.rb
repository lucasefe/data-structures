array = [5, 9, 2, 7, 1]

1.upto(array.length) do |i|
  1.upto(array.length - i) do |j|
    if array[j-1] > array[j]
      array[j-1], array[j] = array[j], array[j-1]
    end
  end
end

puts array.inspect
