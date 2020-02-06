# Once you complete the previous exercise, change the way the users are displayed:
# print them grouped by cohorts. To do this, you'll need to get a list of all
# existing cohorts (the map() method may be useful but it's not the only option),
# iterate over it and only print the students from that cohort.

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

# prints all the students details with a centered layout
def print(students)
  students.each_with_index do |student, index|
    puts "#{index+1}".center(50)
    print_single(student)
  end
end

#prints a single student's details with a centered layour
def print_single(student)
  puts "#{student[:name]}".center(50)
  puts "(#{student[:cohort]} cohort)".center(50)
end

def print_footer(students)
  puts "\n"
  puts "Overall, we have #{students.count} great students".center(50)
  puts "\n"
end

# pulling a list of current cohorts
def cohort_list(students)
    cohort_list = []
    students.each {|student| cohort_list << student[:cohort]}
    current_cohorts = cohort_list.uniq
    puts "Current cohorts:"
    current_cohorts.each {|cohort| puts cohort}
end

# showing the students in a selected cohort
def students_in_cohort(students)
  puts "\nWhich cohort would you like to view?"
  input = gets.chomp
  cohort_count = 0
  cohort_array = Array.new { [] }
  students.each do |student|
    student.each { |key, value| (cohort_count += 1; cohort_array << student ) if value == input }
  end
  roll_call(cohort_array)
  cohort_array
end

# printing the heading/student list and footer in one method
def roll_call(students)
  print_header
  print(students)
  print_footer(students)
end

students = input_students
cohort_list(students)
cohorts = students_in_cohort(students)


# # def print(students)
#   students_by_cohort = {}
#   students.each do |student|
#     student_cohort = student[:cohort]
#     if students_by_cohort[student_cohort] == nil
#       students_by_cohort[student_cohort] =[]
#     end
#     students_by_cohort[student_cohort].push(student[:name])
#   end
#   puts "What cohort do you want to print?"
#   cohort_print = gets.chomp
#   students_by_cohort.each do |key, value|
#     if cohort_print == key
#       puts value
#     end
#   end
# end
