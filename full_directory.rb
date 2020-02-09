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
  puts "4. Show the students by letter"
  puts "5. Correct a typo"
  puts "6. Save the student list"
  puts "7. Load the student list"
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
  when "4" then letter_list; which_letter
  when "5" then typo
  when "6" then save_students
  when "7" then find_file; load_students(filename = "students.csv")
  when "9" then exit
  else
    puts "I don't know what you meant, try again"
  end
end

# question method
def question(string)
  puts string
  reply = STDIN.gets.chomp
  return "n/a" if reply == ""
  return reply
end

# inputting student information
def input_students
  while true do
    name = question("Please enter the names of the students\nTo finish, just hit return twice")
    break if name == "n/a"
    cohort = question("Please enter a cohort")
    student_data(name, cohort)
      @students.count == 1 ? (puts "Now we have #{@students.count} student") : (puts "Now we have #{@students.count} students")
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
  @students.each_with_index { |student, index| puts "#{index+1}".center(50); print_single(student) }
  @students.count == 1 ? (puts "Overall, we have #{@students.count} great student") : (puts "Overall, we have #{@students.count} great students")
end
# For the moment making this a separate method for cohort roll_call
def cohort_call(cohort)
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
  cohort.each_with_index { |student, index| puts "#{index+1}".center(50); print_single(student) }
  cohort.count == 1 ? (puts "Overall, we have #{cohort.count} great student in this cohort") : (puts "Overall, we have #{cohort.count} great students in this cohort")
end
#prints a single student's details with a centered layour
def print_single(student)
  puts "#{student[:name]}".center(50)
  puts "(#{student[:cohort]} cohort)".center(50)
end

# pulling a list of current cohorts
def cohort_list
  month_map = { "January": 1, "February": 2, "March": 3, "April": 4,
    "May": 5, "June": 6, "July": 7, "August": 8, "September": 9,
    "October": 10, "November": 11, "December": 12 }
  cohort_list = []
  @students.each {|student| cohort_list << student[:cohort]}
  current_cohorts = cohort_list.uniq
  puts "Current cohorts:"
  current_cohorts.each do |cohort|
    month_map.each do |month, value|
      if cohort == month
        current_cohorts.sort_by(value)
      end
    end
  end
end

# showing the students in a selected cohort
def students_in_cohort
  input = question("Which cohort would you like to view?")
  cohort_count = 0
  cohort_array = Array.new { [] }
  @students.each do |student|
    student.each { |key, value| (cohort_count += 1; cohort_array << student ) if value == input }
  end
  cohort_call(cohort_array)
  cohort_array
end

# pulling list of available letters
def letter_list
    letters = []
    @students.each {|student| letters << student[:name][0]}
    available_letters = letters.uniq.sort
    puts "Letters currently available:"
    available_letters.each {|char| puts char}
end

# print out students beginning with a certain letter
def which_letter
  letter = question("Show students beginning with [input letter]")
  @students.each {|student| print_single(student) if student[:name].start_with?(letter.upcase)}
end

# typo method
def typo
  while true do
    student_info = question("\nWhich student's information do you want to correct?")
    break if student_info == "n/a"
    @students.each_with_index do |student, index|
      if student_info == student[:name]
        print_single(student)
        category_info = question("\nWhat category do you want to change?")
        student.each do |key, value|
          if category_info.to_sym == key
            correction = question("Enter correction")
            student[key] = correction
            print_single(student)
          end
        end
      end
    end
  end
end


# saving student information
def save_students
  filename = question("Which file would you like to save to?")
  (puts "That file does not exist"; filename = question("Which file would you like to save to?")) while !File.exist?(filename)
  file = CSV.open(filename, "w") {|csv| @students.each {|student| csv << [student[:name], student[:cohort]]}}
  puts "Your students have been saved"
end

# Finding the correct file to load
def find_file(filename = "students.csv")
  filename = question("Which file would you like to load?")
  filename = "students.csv" if filename == "n/a"
  (puts "That file does not exist"; filename = question("Which file would you like to load?")) while !File.exist?(filename)
  return filename
end

# splitting load_file method so it works properly with try_load_students method
def load_students(filename = "students.csv")
  file = CSV.foreach(filename) {|csv| (name, cohort = csv; student_data(name, cohort))}
  puts "Your student list has loaded"
end

# auto load a file
def try_load_students
  filename = ARGV.first
  filename = "students.csv" if filename.nil?
  File.exists?(filename) ? (load_students(filename); puts "Loaded #{@students.count} from #{filename}") : (puts "Sorry, #{filename} doesn't exist."; exit)
end

try_load_students
interactive_menu
