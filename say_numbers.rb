

class Voice

  NUM = {
    1 => 'one',
    2 => 'two',
    3 => 'three',
    4 => 'four',
    5 => 'five',
    6 => 'six',
    7 => 'seven',
    8 => 'eigth',
    9 => 'nine',
    10 => 'ten',
    11 => 'eleven',
    12 => 'twelve',
    13 => 'thirteen',
    14 => 'fourteen',
    15 => 'fifteen',
    16 => 'sixteen',
    17 => 'seventeen',
    18 => 'eighteen',
    19 => 'nineteen',
    20 => 'twenty',
    30 => 'thirty',
    40 => 'forty',
    50 => 'fifty',
    70 => 'seventy',
    80 => 'eighty',
    90 => 'ninety',
  }

  SEP = [nil, 'thousand', 'million']

  def initialize(number)
    @number = number.to_s
  end

  def say
    output = []
    groups_of(3, @number).each_with_index do |chunk, i|
      output.push "#{say_chunk(chunk)} #{SEP[i]}"
    end
    output.reverse.join ' '
  end

  def basic_number(number)
    NUM[number.gsub(/^0*/, '').to_i]
  end

  def say_chunk(number)
    return basic_number(number) if number.to_i < 100
    [
      basic_number(number[0]), 
      'hundred',
      basic_number(number[1] + "0"),
      basic_number(number[2]),
    ].join(" ")
  end

  def groups_of(digits, numbers)
    (numbers.length - 1).step(0, -3).map do |n|
      n < 3 ? numbers[0..n] : numbers[(n - 2)..n] 
    end
  end

  private

end

puts Voice.new(1002).say
puts Voice.new(1222).say
puts Voice.new(40200).say


