# Rewrite the each() method that prints all students
# using while or until control flow methods (Loops).

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
  puts "The students of Villains Academy"
  puts "-----------------"
end

# prints the students's names using a while loop
def print(students)
  student_number = 0
  while student_number < students.count do
    puts students.each { |x| x.values[0]}
    student_number += students.count
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end


students = input_students
print_header
print(students)
print_footer(students)
