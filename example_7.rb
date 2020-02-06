# In the input_students method the cohort value is hard-coded.
# How can you ask for both the name and the cohort?
# What if one of the values is empty?
# Can you supply a default value? The input will be given to you as a string?
# How will you convert it to a symbol? What if the user makes a typo?

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
