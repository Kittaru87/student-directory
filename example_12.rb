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
#  
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
  input = question("\nWhich cohort would you like to view?")
  cohort_count = 0
  cohort_array = Array.new { [] }
  students.each do |student|
    student.each { |key, value| (cohort_count += 1; cohort_array << student ) if value == input }
  end
  roll_call(cohort_array)
  cohort_array
end

# typo method
def typo(cohorts)
  input = question("\nIs all the information accurate? Y/N")
  while true do
    # if the info is correct, print out list again
    (roll_call(cohorts); break) if input == "Y"
    if input == "N"
      student_info = question("Which student's information do you want to correct?")
      cohorts.each_with_index do |student, index|
        if student_info == student[:name]
        print_single(student)
        category_info = question("What category do you want to change - name, cohort, country, height or hobbies?")
        student.each do |key, value|
          if category_info.to_sym == key
            correction = question("Enter correction")
            student[key] = correction
            print_single(student)
          end
        end
        end
      end
    input = question("\nIs all the information accurate? Y/N")
    end
  end
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
typo(cohorts)
