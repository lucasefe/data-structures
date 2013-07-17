
data = [32, 43, 2, 8, 9, 1]

def sort(array)
  n = array.size - 1
  
  n.times do |i|
    index_min = i
  
    (i + 1).upto(n) do |j|
      index_min = j if array[j] < array[index_min]
    end
    
    # Yep, in ruby I can do that, no aux variable. w00t!
    array[i], array[index_min] = array[index_min], array[i] if index_min != i
  end
  array
end

puts sort data
