# Right now if we have only one student, the user will see a message "Now we have 1 students",
# whereas it should be "Now we have 1 student". How can you fix it so that it used singular form
# when appropriate and plural form otherwise?

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


# typo method
def typo(students)
  puts "\nIs all the information accurate? Y/N"
  input = gets.chomp
  while true do
    # if the info is correct, print out list again
    (roll_call(students); break) if input == "Y"
    if input == "N"
      puts "Which student's information do you want to correct?"
      student_info = gets.chomp
      students.each_with_index do |student, index|
        if student_info == student[:name]
          print_single(student)
          puts "\nWhat category do you want to change?"
          category_info = gets.chomp
          student.each do |key, value|
            if category_info.to_sym == key
              puts "Enter correction"
              correction = gets.chomp
              student[key] = correction
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
roll_call(students)
typo(students)
