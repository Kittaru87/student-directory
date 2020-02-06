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
    puts "Now we have #{students.count} students"
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
    print_single(student)
  end
end

#prints a single student's details with a centered layour
def print_single(student)
  puts "#{student[:name]}".center(50)
  puts "(#{student[:cohort]} cohort)".center(50)
end

#prints the footer with student count
def print_footer(students)
  puts "Overall, we have #{students.count} great student\n" if students.count == 1
  puts "Overall, we have #{students.count} great students\n" if students.count == 0 || students.count > 1
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

# typo method
def typo(cohorts)
  puts "\nIs all the information accurate? Y/N"
  input = gets.chomp
  while true do
    # if the info is correct, print out list again
    (roll_call(cohorts); break) if input == "Y"
    if input == "N"
      puts "Which student's information do you want to correct?"
      student_info = gets.chomp
      cohorts.each_with_index do |student, index|
        if student_info == student[:name]
        print_single(student)
        puts "What category do you want to change?"
        category_info = gets.chomp
        student.each do |key, value|
          if category_info.to_sym == key
            puts "Enter correction"
            correction = gets.chomp
            student[key] = correction
            print_single(student)
          end
        end
        end
      end
    puts "\nIs all the information accurate? Y/N"
    input = gets.chomp
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
