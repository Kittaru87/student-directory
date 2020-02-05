# def interactive_menu
#   # 1. print the menu and ask the user what to do
#   # 2. read the input and save it into a variable
#   # 3. do what the user has asked
#   # 4. repeat from step 1
# end
# attempting to incorporate the cohorts, plus extra information into the interactive_menu


@students = []

# getting student information
def input_students
  puts "Please enter the name and cohort of the student, separated by a comma"
  puts "To finish, just hit return twice"
  # empty array
  students = []
  # while loop for getting information
  while true do
    name = STDIN.gets.chomp
    break if name == ""
    #pulling the cohort from the input and turning into a symbol
    cohort = name.split.last
    #removing cohort and comma from the name
    name = name.split(' ')[0...-1].join(' ').chop
    puts "Enter country of birth"
    country = STDIN.gets.chomp
      country = "n/a" if country == ""
    puts "Enter height"
    height = STDIN.gets.chomp
      height = "n/a" if height == ""
    puts "Enter hobbies"
    hobbies = STDIN.gets.chomp
      hobbies = "n/a" if hobbies == ""
    # add the student hash to the array
    students << {name: name, cohort: cohort, country: country, height: height, hobbies: hobbies}
    students.count == 1 ? (puts "Now we have #{students.count} student") : (puts "Now we have #{students.count} students")
    puts "Please enter the next student name and cohort"
    end
   # exits the program if student array is empty else returns the array
   students == [] ? exit : students
end

def save_students
  # open file for writing
  file = File.open("students-examples.csv", "w")
  # iterative over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:country], student[:height], student[:hobbies]]
    csv_line = student_data.join(",")
    # writes to the file and not on the screen
    file.puts csv_line
  end
  file.close
end

# loading student information from csv file
def load_students(filename = "students-examples.csv")
  file = File.open("students-examples.csv", "r")
  # define instance variable or get a undefined method for nil class error
  file.readlines.each do |line|
    name, cohort, country, height, hobbies = line.chomp.split(",")
    @students << {name: name, cohort: cohort, country: country, height: height, hobbies: hobbies}
  end
  file.close
end

# auto loading a csv file data
def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

# printing the roll-call header
def print_header
  puts "The students of Villains Academy".center(50)
  puts "-----------------".center(50)
end

# prints a single student's details with a centered layour
def print_single(student)
  puts "#{student[:name]}".center(50)
  puts "(#{student[:cohort]} cohort)".center(50)
  puts "County of birth: #{student[:country]}".center(50)
  puts "Height: #{student[:height]}".center(50)
  puts "Hobbies: #{student[:hobbies]}".center(50)
  puts "\n"
end

# prints all the students details with a centered layout
def print_student_list
  @students.each_with_index do |student, index|
    puts "#{index+1}".center(50)
    print_single(student)
  end
end

# prints the footer with student count
def print_footer()
  @students.count == 1 ? (puts "Overall, we have #{@students.count} great student\n") : (puts "Overall, we have #{@students.count} great students\n")
end

# print out students beginning with a certain letter
def which_letter()
  puts "Show students beginning with [input letter]"
  letter = gets.chomp
  @students.each {|student| puts "#{student[:name]} (#{student[:cohort]} cohort)" if student[:name].start_with?(letter.upcase)}
end

# prints out student names of length less than 12
def short_name()
  @students.each { |student| puts "#{student[:name]} (#{student[:cohort]} cohort)" if student[:name].length < 12 }
end

# pulls list of current cohorts, asks for input then lists that cohort's students + count
def cohorts()
  # pulling a list of current cohorts
  cohort_list = []
  @students.each {|student| cohort_list << student[:cohort]}
  current_cohorts = cohort_list.uniq
  puts "Current cohorts:"
  current_cohorts.each {|cohort| puts cohort}
 # selecting which cohort's students to view + counting number of students
  puts "\nWhich cohort would you like to view?"
  input = gets.chomp
  # push students in selected cohort into new global array to be called in the typo method
  cohort_count = 0
  cohort_array = Array.new { [] }
  @students.each do |student|
    student.each { |key, value| (cohort_count += 1; cohort_array << student ) if value == input }
  end
  # printing out the full list of students in the selected cohort
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
def roll_call()
  print_header
  print_student_list
  print_footer()
end

#prints the interactive_menu
def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students-examples.csv"
  puts "4. Load the list from students-examples.csv"
  puts "9. Exit" # 9 because we'll be adding more items
end

# case statement method
def process(selection)
  @students
  case selection
  when "1"
    @students = input_students
  when "2"
    roll_call
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "I don't know what you mean, try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

try_load_students
interactive_menu
#cohorts = cohorts(@students)
#typo(cohorts)
