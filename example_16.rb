# Continue refactoring the code. Which method is a bit too long?
# What method names are not clear enough? Anything else you'd
# change to make your code look more elegant? Why?

# not sure how to change the case statement into something else - was looking at the Hash
# option but couldn't make it work

@students = [] # an empty array accessible to all methods

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

# slight refactoring of the case statement
# tried methods in hash instead and lamdas
def process(selection)
  case selection
  when "1" then input_students
  when "2" then roll_call
  when "3" then save_students
  when "4" then load_students
  when "9" then exit
  else
    puts "I don't know what you meant, try again"
  end
end

#refactored slightly to remove duplicate gets line
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  while true do
    name = STDIN.gets.chomp
    break if name.empty?
    student_data(name)
    puts "Now we have #{@students.count} students"
  end
end

# adding data to student array
def student_data(name)
  @students << {name: name, cohort: :november}
end

#combined the three methods into 1, seeing as we were calling them all at the same time anyway
def roll_call
  puts "The students of Villains Academy"
  puts "-------------"
  @students.each { |student| puts "#{student[:name]} (#{student[:cohort]} cohort)"}
  puts "Overall, we have #{@students.count} great students"
end

# saving student information
def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

# loading student information from any file - the default being students.csv
def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  #refactored this each method to go onto one line
  file.readlines.each {|line| (name, cohort = line.chomp.split(","); student_data(name))}
  file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  filename = "students.csv" if filename.nil? # get out of the method if it isn't given
  #refactoring this if/else statement
  File.exists?(filename) ? (load_students(filename); puts "Loaded #{@students.count} from #{filename}") : (puts "Sorry, #{filename} doesn't exist."; exit)
end

try_load_students
interactive_menu
