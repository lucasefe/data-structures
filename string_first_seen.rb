require 'test/unit'

include Test::Unit::Assertions


class String
  def first_duplicate
    appearances = []
    chars.each do |char|
      return char if appearances.include?(char)
      appearances << char
    end
  end
end

assert "abanico".first_duplicate == "a"
assert "abcdefghhh".first_duplicate == "h"

