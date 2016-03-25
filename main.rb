=begin
	A simple TODOs App
=end
class ToDos
  #class fields / or static fields
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
	def initialize()
		while 1
			# always gets the input 
			print "Todo: enter command ☻ :"
			prompt =  gets.chomp.downcase

			# test input
			case prompt
				when "add"
					new_task
				when "info"
					#info
				when "help"
					help
				when "count"
					count
				when "list"
					list
				when "version"
					#version
				when "update"
					#help
				when "bye"
					bye
				else
					puts "Todo: invalid command *#{prompt}* (typing help will show vaild commands ) (RuntimeError)"
			end
		end
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
	def count
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
	def list
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

	def new_task
		while 1
			print "Task Name/Description:"
			task_name = gets.chomp!
			print "Completion Date:"
			completion_date = gets.chomp!
			@input_date = Time.now
			add_todo(task_name , completion_date)
			response = add_new_task?
			if  response == "n" or response =="no"
				puts "________________________________________"
				break
			elsif  response == "y" or response == "yes"
				puts "________________________________________"
				next
			else 
				puts "Todo: invalid response!! "
				add_new_task?
			end
		end
	end

	def add_new_task?
		print "Add new task ?  y/n: "
		response =  gets.chomp.downcase
		return response
	end

	def help
		print  (<<-EOH)
		Usage : <command> [<args>]
		Some useful Todo commands are :

		add                add a new Todo 
		info               Display the full details of a task
		count              Gives a total count of all Todos
		list               List all Todos availabel
		update
		version
		bye
		EOH
	end

	def bye
		exit
	end
end
#Object initialization and  method / class method calls
main = ToDos.new


# print  <<EOF
# Usage : <command>
# Some useful Todo commands are :
# EOF
# end

# puts RubyClass.info
# PythonClass  = ToDos.new("PythonClass "  , "22-03-2016")
# JavaClass    = ToDos.new("JavaClass   "  , "22-03-2016")
# Hackthon2016 = ToDos.new("Hackthon2016"  , "31-12-2016")
# Ispace 		 = ToDos.new("Ispace Pitch"  , "25-06-2016")

# RubyClass.info
# JavaClass.info
# PythonClass.info
# Hackthon2016.info

# ToDos.list
# ToDos.count

# functionalites
# getuser input
# 	- *get task name (only required)
# 	- get completion_date
# update

# notifications
# database integration