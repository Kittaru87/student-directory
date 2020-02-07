# We are opening and closing the files manually. Read the documentation of
# the File class to find out how to use a code block (do...end) to access a
# file, so that we didn't have to close it explicitly (it will be closed
# automatically when the block finishes). Refactor the code to use a code block.
require "csv"
csv = CSV.new("students.csv")

@students = [] # an empty array accessible to all methods

def print_menu
  puts "1. Input the students"
  puts "2. Show all the students"
  puts "3. Show the students by cohort"
  puts "4. Save the student list"
  puts "5. Load the student list"
  puts "9. Exit"
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
  when "1" then input_students
  when "2" then roll_call
  when "3" then cohort_list; students_in_cohort
  when "4" then save_students
  when "5" then load_students
  when "9" then exit
  else
    puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  while true do
    name = STDIN.gets.chomp
    break if name.empty?
    puts "Please enter a cohort"
    cohort = STDIN.gets.chomp
    student_data(name, cohort)
      students.count == 1 ? (puts "Now we have #{students.count} student") : (puts "Now we have #{students.count} students")
  end
end

# adding data to student array
def student_data(name, cohort)
  @students << {name: name, cohort: cohort}
end

# combined the three methods into 1, seeing as we were calling them all at the same time anyway
def roll_call
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
  @students.each { |student| puts "#{student[:name]} (#{student[:cohort]} cohort)".center(50)}
  @students.count == 1 ? (puts "Overall, we have #{@students.count} great student\n") : (puts "Overall, we have #{@students.count} great students\n")
end
# For the moment making this a separate method
def cohort_call(cohort)
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
  cohort.each { |student| puts "#{student[:name]} (#{student[:cohort]} cohort)".center(50)}
  cohort.count == 1 ? (puts "Overall, we have #{cohort.count} great student in this cohort\n") : (puts "Overall, we have #{cohort.count} great students in this cohort\n")
end

# pulling a list of current cohorts
def cohort_list
    cohort_list = []
    @students.each {|student| cohort_list << student[:cohort]}
    current_cohorts = cohort_list.uniq
    puts "Current cohorts:"
    current_cohorts.each {|cohort| puts cohort}
end

# showing the students in a selected cohort
def students_in_cohort
  puts "Which cohort would you like to view?"
  input = gets.chomp
  cohort_count = 0
  cohort_array = Array.new { [] }
  @students.each do |student|
    student.each { |key, value| (cohort_count += 1; cohort_array << student ) if value == input }
  end
  cohort_call(cohort_array)
  cohort_array
end

# saving student information
def save_students
  puts "Which file would you like to save to?"
  filename = gets.chomp
  # open the file for writing + do |file| end to auto close
  file = CSV.open(filename, "w") {|csv|
  # iterate over the array of students
  # using csv class to push data into file in the correct format automatically
    @students.each {|student| csv << [student[:name], student[:cohort]]}
  }
  puts "Your students have been saved"
end

# loading student information from any file - the default being students.csv
def load_students(filename = "students.csv")
  puts "Which file would you like to load?"
  filename = gets.chomp
  filename = "students.csv" if filename.empty?
  (puts "this file does not exist\nWhich file would you like to load?"; filename = gets.chomp) while !File.exist?(filename)
  # do |file| end to auto close
  file = CSV.foreach(filename) {|csv| (name, cohort = csv; student_data(name, cohort))}
  puts "Your student list has loaded"
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  filename = "students.csv" if filename.nil? # get out of the method if it isn't given
  #refactoring this if/else statement
  File.exists?(filename) ? (load_students(filename); puts "Loaded #{@students.count} from #{filename}") : (puts "Sorry, #{filename} doesn't exist."; exit)
end

#try_load_students
interactive_menu
