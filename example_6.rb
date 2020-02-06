# Research how the method center() of the String class works.
# Use it in your code to make the output beautifully aligned.
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first names
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
   end
   # returns the array of students
   students
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
  end
end

def print_footer(students)
  puts "\n"
  puts "Overall, we have #{students.count} great students".center(50)
end


students = input_students
print_header
print(students)
print_footer(students)
