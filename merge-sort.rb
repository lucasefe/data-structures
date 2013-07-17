a1 = [0, 1,3,5,7,9]
a2 = [2,4,6,8,10]
a3 = []

i1 = i2 = 0

while i1 < a1.length && i2 < a2.length do 
  if a1[i1] < a2[i2]
    a3 << a1[i1]
    i1 += 1
  elsif a2[i2] < a1[i1]
    a3 << a2[i2]
    i2 += 1
  else
    a3 << a1[i1]
    i1 += 1
    i2 += 1
  end
end

while i1 < a1.length do 
  a3 << a1[i1]
  i1 += 1
end

while i2 < a2.length do 
  a3 << a2[i2]
  i2 += 1
end
puts a3.inspect




