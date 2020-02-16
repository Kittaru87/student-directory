# Write a short program that reads its own source code
# (search StackOverflow to find out how to get the name of the
# currently executed file) and prints it on the screen.

  # def source_code
  #   puts File.basename(__FILE__)
  # end
  #
  # source_code

  # $0
  # puts __FILE__
  # puts File.dirname(__FILE__)

# https://stackoverflow.com/questions/8577223/ruby-get-the-file-being-executed

# def method;"def method;;end;puts method()[0, 11] + 34.chr + method + 34.chr + method()[11, method.length-11]";end;puts method()[0, 11] + 34.chr + method + 34.chr + method()[11, method.length-11]

# def s;"def s;;end;puts s()[0,6]+34.chr+s+34.chr+s()[6,s.length-6]";end;puts s()[0,6]+34.chr+s+34.chr+s()[6,s.length-6]

# https://blog.chaps.io/2015/10/01/generating-quines-in-ruby.html

quine = "\nputs \"quine = \" + quine.inspect + quine"
puts "quine = " + quine.inspect + quine
