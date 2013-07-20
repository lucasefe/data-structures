class String
   def rev
    out     = ""
    threads = []
    chars.each_with_index { |chr, i| 
      threads.push Thread.new { sleep (length-i)*0.01; out << chr } }
    threads.map(&:join)
    out
  end
end

puts "lucas".rev

