# def interactive_menu
#   # 1. print the menu and ask the user what to do
#   # 2. read the input and save it into a variable
#   # 3. do what the user has asked
#   # 4. repeat from step 1
# end
# attempting to incorporate the cohorts, plus extra information into the interactive_menu


@students = []

# question method
def question(string)
  puts string
  reply = STDIN.gets.chomp()
  return "n/a" if reply == ""
  return reply
end

def input_students
  students = []
  while true do
    name = question("Please enter the name\nTo finish, just hit return twice")
    break if name == "n/a"
    cohort = question("Enter cohort")
    # add the student hash to the array
    students << {name: name, cohort: cohort}
    students.count == 1 ? (puts "Now we have #{students.count} student") : (puts "Now we have #{students.count} students")
    end
   # exits the program if student array is empty else returns the array
   students == [] ? exit : students
end

def save_students
  # open file for writing
  file = File.open("students-examples.csv", "w")
  # iterative over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
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
    name, cohort = line.chomp.split(",")
    @students << {name: name, cohort: cohort}
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

# prints all the students details with a centered layout
def print_student_list
  @students.each_with_index do |student, index|
    puts "#{index+1}".center(50)
    puts "#{student[:name]}".center(50)
    puts "(#{student[:cohort]} cohort)".center(50)
  end
end

# prints the footer with student count
def print_footer()
  @students.count == 1 ? (puts "Overall, we have #{@students.count} great student\n") : (puts "Overall, we have #{@students.count} great students\n")
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
  when "1" then @students = input_students
  when "2" then roll_call
  when "3" then save_students
  when "4" then load_students
  when "9" then exit
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
