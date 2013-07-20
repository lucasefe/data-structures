require 'test/unit'
 
include Test::Unit::Assertions
 
class String
  
  def contains?(str)
    len_str = str.length

    chars.each_with_index do |char, i|
      return true if self[i..(len_str + 1)] == str
    end
    return false
  end
    
end
 
 
assert "foasdfasdfsadf".contains?("asdf") == true
assert !"foasd".contains?("aaa")
#
