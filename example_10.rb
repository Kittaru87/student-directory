# We've been using the chomp() method to get rid of the last return character.
# Find another method among those provided by the String class that could be
# used for the same purpose (although it will require passing some arguments).

# .chop removes the last character from the aligned
# string[-1] would also remove the last character

# getting student information
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first names
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "Please enter the cohort"
    cohort = gets.chomp
    puts "November" if cohort == ""
    # add the student hash to the array
    students << {name: name, cohort: cohort}
    students.count == 1 ? (puts "Now we have #{students.count} student") : (puts "Now we have #{students.count} students")
    puts "Please enter the next student name and cohort"
    # get another name from the user
    name = gets.chomp
   end
   # returns the array of students
   students
 end

#printing the roll-call header
def print_header
  puts "The students of Villains Academy".center(50)
  puts "-----------------".center(50)
end

# prints all the students details with a centered layout
def print(students)
  students.each_with_index do |student, index|
    puts "#{index+1}".center(50)
    puts "#{student[:name]}".center(50)
    puts "(#{student[:cohort]} cohort)".center(50)
  end
end

#prints the footer with student count
def print_footer(students)
  puts "Overall, we have #{students.count} great student\n" if students.count == 1
  puts "Overall, we have #{students.count} great students\n" if students.count == 0 || students.count > 1
end


# printing the heading/student list and footer in one method
def roll_call(students)
  print_header
  print(students)
  print_footer(students)
end

students = input_students
roll_call(students)
