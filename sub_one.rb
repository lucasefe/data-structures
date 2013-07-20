require 'test/unit'
 
include Test::Unit::Assertions
 
class String
  def sub_one
    ints = self.chars.map(&:to_i)
    head = ints[0..-2]
    
    sub = if ints.last == 0 
      head.join.sub_one + '9'
    else
      head.join + (ints.last - 1).to_s
    end
    sub.sub(/^0.*/, '')
  end
end
 
assert "9900".sub_one == "9899"
assert "15".sub_one == "14"
puts "10".sub_one
assert "10".sub_one == "9"
assert "1000000000000000000000005".sub_one == "1000000000000000000000004"
