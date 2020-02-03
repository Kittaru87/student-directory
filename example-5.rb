# Our code only works with the student name and cohort.
# Add more information: hobbies, country of birth, height, etc

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
    puts "Enter hobbies"
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
  puts "The students of Villains Academy"
  puts "-----------------"
end

# prints the students number, name and cohort
def print(students)
  students.each_with_index do |student, index|
    puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)"
    puts "County of birth: #{student[:country]}"
    puts "Height:#{student[:height]}"
    puts "Hobbies include: #{student[:hobbies]}"
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
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
