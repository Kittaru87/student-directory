# Research how the method center() of the String class works.
# Use it in your code to make the output beautifully aligned.

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # empty array
  students = []
  # while loop for getting information
  while true do
    name = gets.chomp
      if name == ""
        break
      end
    puts "Enter country of birth"
    country = gets.chomp
    puts "Enter height"
    height = gets.chomp
    puts "Enter evil hobbies"
    hobbies = gets.chomp
    # add the student hash to the array
    students << {name: name, cohort: :november, country: country, height: height, hobbies: hobbies}
    puts "Now we have #{students.count} students"
    puts "Please enter the next student name"
    # get another name from the user
    end
   # returns the array of students
  students
end

# print out students beginning with a certain letter
def which_letter(students)
  puts "Show students beginning with [input letter]"
  letter = gets.chomp

  students.each do |student|
    if student[:name].start_with?(letter.upcase)
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_header
  puts "The students of Villains Academy".center(50)
  puts "-----------------".center(50)
end

# prints the students details in a centered layout
def print(students)
  students.each_with_index do |student, index|
    puts "#{index+1}".center(50)
    puts "#{student[:name]}".center(50)
    puts "(#{student[:cohort]} cohort)".center(50)
    puts "County of birth: #{student[:country]}".center(50)
    puts "Height: #{student[:height]}".center(50)
    puts "Evil Hobbies: #{student[:hobbies]}".center(50)
    puts "\n"
  end
end

def print_footer(students)
  puts "\n"
  puts "Overall, we have #{students.count} great students".center(50)
end

# prints out student names of length less than 12
def short_name(students)
  students.each do |student|
    if student[:name].length < 12
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

students = input_students
print_header
print(students)
print_footer(students)
#which_letter(students)
#short_name(students)
