
class Array
  def shuffle_it
    array = dup
    (array.length - 1).step(0, -1).each do |i|
      random_index = rand(i+1)
      temp = array[i]
      array[i] = array[random_index]
      array[random_index] = temp
    end
    array
  end
end

data = 1.step(100).to_a

7.times do 
  puts data.shuffle_it.inspect
end
