# What happens if the user doesn't enter any students?
# It will try to print an empty list.
# How can you use an if statement (Control Flow) to only print the list if there is at least one student in there?

# question method
def question(string)
  puts string
  reply = gets.chomp()
  return "n/a" if reply == ""
  return reply
end
# input student info
def input_students
  students = []
  while true do
    name = question("Please enter the name\nTo finish, just hit return twice")
    break if name == "n/a"
    cohort = question("Enter cohort")
    country = question("Enter country of birth")
    height = question("Enter height")
    hobbies = question("Enter hobbies")
    # add the student hash to the array
    students << {name: name, cohort: cohort, country: country, height: height, hobbies: hobbies}
    students.count == 1 ? (puts "Now we have #{students.count} student") : (puts "Now we have #{students.count} students")
    end
   # exits the program if student array is empty else returns the array
   students == [] ? exit : students
end

#printing the roll-call header
def print_header
  puts "The students of Villains Academy".center(50)
  puts "-----------------".center(50)
end

#prints a single student's details with a centered layour
def print_single(student)
  puts "#{student[:name]}".center(50)
  puts "(#{student[:cohort]} cohort)".center(50)
  puts "County of birth: #{student[:country]}".center(50)
  puts "Height: #{student[:height]}".center(50)
  puts "Hobbies: #{student[:hobbies]}".center(50)
  puts "\n"
end

# prints all the students details with a centered layout
def print(students)
  students.each_with_index do |student, index|
    puts "#{index+1}".center(50)
    print_single(student)
  end
end

#prints the footer with student count
def print_footer(students)
  students.count == 1 ? (puts "Overall, we have #{students.count} great student in this cohort\n") : (puts "Overall, we have #{students.count} great students in this cohort\n")
end

# printing the heading/student list and footer in one method
def roll_call(students)
  print_header
  print(students)
  print_footer(students)
end

students = input_students
roll_call(students)
