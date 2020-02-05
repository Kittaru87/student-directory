# Right now if we have only one student, the user will see a message "Now we have 1 students",
# whereas it should be "Now we have 1 student". How can you fix it so that it used singular form
# when appropriate and plural form otherwise?

def input_students
  puts "Please enter the name and cohort of the student, separated by a comma"
  puts "To finish, just hit return twice"
  # empty array
  students = []
  # while loop for getting information
  while true do
    name = gets.chomp
    break if name == ""
    #pulling the cohort from the input and turning into a symbol
    cohort = name.split.last
    #removing cohort and comma from the name
    name = name.split(' ')[0...-1].join(' ').chop
    puts "Enter country of birth"
    country = gets.chomp
      country = "n/a" if country == ""
    puts "Enter height"
    height = gets.chomp
      height = "n/a" if height == ""
    puts "Enter hobbies"
    hobbies = gets.chomp
      hobbies = "n/a" if hobbies == ""
    # add the student hash to the array
    students << {name: name, cohort: cohort, country: country, height: height, hobbies: hobbies}
    puts "Now we have #{students.count} student" if students.count == 1
    puts "Now we have #{students.count} students" if students.count == 0 || students.count > 1
    puts "Please enter the next student name and cohort"
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
  puts "County of birth: #{student[:country]}".center(50)
  puts "Height: #{student[:height]}".center(50)
  puts "Hobbies: #{student[:hobbies]}".center(50)
  puts "\n"
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
        puts "What category do you want to change - name, cohort, country, height or hobbies?"
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
