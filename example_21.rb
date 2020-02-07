# Write a short program that reads its own source code
# (search StackOverflow to find out how to get the name of the
# currently executed file) and prints it on the screen.

  def source_code
    puts File.basename(__FILE__)
  end

  source_code


# https://stackoverflow.com/questions/8577223/ruby-get-the-file-being-executed
