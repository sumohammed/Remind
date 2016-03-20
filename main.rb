=begin
	A simple TODOs App
=end
class ToDos
	# class fields / or static fields
	@@todo_base = Hash.new
	@@todo_count = 0

	# attribute accessors
	attr_accessor :input_date
	attr_accessor :task

=begin 
	initialize each activity with the Activity Name and Completion Date
	automatically the activity is added with the time stamp i.e 
	the activity entry date and time
=end
	def initialize(task , completion_date)
		@input_date = Time.now
		add_todo(task , completion_date)
	end
=begin
	this method is called only by the constructor and not
    outside
=end
	def add_todo(task , completion_date)
		@task = task
		@@todo_base[task] = completion_date
		@@todo_count+=1
	end
=begin
	this method prints to the standard output i.e console
	the details of an activity(i.e an instance of the todos class 
	in other words the object)
	Usage: this is called on the object by supplying the name of the 
		   activity
=end
	def info
		puts "\t\tToDos";
		puts "________________________________________"
		puts "Task Name      : #{@task}"
		puts "Input Date     : #{@input_date}"
		puts "Completion Date: #{@@todo_base[task]}"
		puts "________________________________________"
	end
=begin
	this method prints to he  stdout the total number of 
	todos e.g You have 2 task(s) currently in ToDOs
	NB : This is a static or class method meaning this method belongs
	to this class i.e todos and not a particular instance 
	in other words this method cannot operate on an object but rather
	the class
=end
	def self.count
		puts ""
		puts "________________________________________"
		puts  "\t\tToDos Count"
		puts "________________________________________"
		puts "You have #{@@todo_count} task(s) currently in ToDOs"
		puts "________________________________________"
	end

=begin
	this method prints to he  stdout the list of list of 
	all the todos with their assigned completion dates
	NB : This is a static or class method meaning this method belongs
	to this class i.e todos and not a particular instance 
	in other words this method cannot operate on an object but rather
	the class
=end

	def self.list
		puts ""
		puts "________________________________________"
		puts  "\t\tToDos List"
		puts  "ToDo\t\t\t Completion Date"
		puts "________________________________________"
		for todo , completion_date in @@todo_base
			puts "#{todo} :------------->#{completion_date}"
		end
		puts "________________________________________"
	end

end

#Object initialization and  method / class method calss calls
RubyClass    = ToDos.new("RubyClass   "  , "21-03-2016")
PythonClass  = ToDos.new("PythonClass "  , "22-03-2016")
JavaClass    = ToDos.new("JavaClass   "  , "22-03-2016")
Hackthon2016 = ToDos.new("Hackthon2016"  , "31-12-2016")
Ispace 		 = ToDos.new("Ispace Pitch"  , "25-06-2016")

RubyClass.info
JavaClass.info
PythonClass.info
Hackthon2016.info

ToDos.list
ToDos.count