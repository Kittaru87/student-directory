# Final full functional student directory with multiple user options, data correction
# and save/load ability

require "csv"
csv = CSV.new("students.csv")

@students = [] # an empty array accessible to all methods

def print_menu
  puts "1. Input the students"
  puts "2. Show all the students"
  puts "3. Show the students by cohort"
  puts "4. Show the students by letter"
  puts "5. Show number of students in each age group"
  puts "6. Correct a typo"
  puts "7. Save the student list"
  puts "8. Load the student list"
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
  when "2" then roll_call(@students)
  when "3" then cohort_list; students_in_cohort
  when "4" then letter_list; which_letter
  when "5" then age_group
  when "6" then typo
  when "7" then save_students
  when "8" then find_file; load_students(filename = "students.csv")
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
    age = question("Please enter the student's age")
    student_data(name, cohort, age)
    @students.count == 1 ? (puts "Now we have #{@students.count} student") : (puts "Now we have #{@students.count} students")
  end
end

# adding data to student array + age groups into integers
def student_data(name, cohort, age)
  @students << {name: name, cohort: cohort, age: age}
  @students.each {|student| student[:age] = student[:age].to_i}
end

# calling the list of students and counting how many there are - used for both all students and cohort list
def roll_call(students)
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
  students.each_with_index {|student, index| puts "#{index+1}".center(50); print_single(student) }
  students.count == 1 ? (puts "Overall, we have #{students.count} great student") : (puts "Overall, we have #{students.count} great students")
end

# prints a single student's details with a centered layout
def print_single(student)
  puts "#{student[:name]}".center(50)
  puts "(#{student[:cohort]} cohort)".center(50)
  puts "Age: #{student[:age]}".center(50)
  puts "\n"
end

# pulling a list of current cohorts in correct month order
def cohort_list
  months = ["January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"]
  cohort_list = []
  @students.each {|student| cohort_list << student[:cohort]}
  current_cohorts = cohort_list.uniq
  puts "Current cohorts:"
  mapped_index = []
  current_cohorts.each {|cohort| months.each_with_index {|month, index| mapped_index << index if cohort == month }}
  sorted_months = mapped_index.sort
  sorted_months.each {|number| puts months[number]}
end

# showing the students in a selected cohort
def students_in_cohort
  input = question("Which cohort would you like to view?")
  cohort_array = Array.new { [] }
  @students.each {|student| student.each {|key, value| cohort_array << student if value == input }}
  roll_call(cohort_array)
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

# method for pulling a list of current age groups
def age_group
  puts "The number of students per age group:"
  age_list = [
  ["Under 18:", 0],
  ["18 - 25:", 0],
  ["26 - 35:", 0],
  ["36 - 50:", 0],
  ["51 - 60:", 0],
  ["61+:", 0]
]

  @students.each do |student|
    case
    when student[:age] < 18
      age_list[0][1] += 1
    when student[:age] <= 25
      age_list[1][1] += 1
    when student[:age] <= 35
      age_list[2][1] += 1
    when student[:age] <= 50
      age_list[3][1] += 1
    when student[:age] <= 60
      age_list[4][1] += 1
    else
      age_list[5][1] += 1
    end
  end
  puts age_list
end

# typo method
def typo
  while true do
    student_info = question("Which student's information do you want to correct?")
    break if student_info == "n/a"
    @students.each_with_index do |student, index|
      if student_info == student[:name]
        print_single(student)
        category_info = question("What category do you want to change?")
        student.each do |key, value|
          if category_info.to_sym == key
            correction = question("Enter correction")
            student[key] = correction
            student[:age] = student[:age].to_i if student[:age].is_a? String
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
  file = CSV.open(filename, "w") {|csv| @students.each {|student| csv << [student[:name], student[:cohort], student[:age]]}}
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
  file = CSV.foreach(filename) {|csv| (name, cohort, age = csv; student_data(name, cohort, age))}
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
