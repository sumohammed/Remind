=begin
	A simple TODOs App
=end
class ToDos
  #class fields / or static fields
	@@todo_base = Hash.new
	@@todo_count = 0
=begin
	initialize each activity with the Activity Name and Completion Date
	automatically the activity is added with the time stamp i.e
	the activity entry date and time
=end
	def initialize()
		welcome_m
		while true
			# always gets the input 
			print "Todo: enter command ☻ :"
			command =  gets.chomp!.downcase
			command_options = command.split()
			# test input
			case command_options[0]
				when "add"
					new_task
				when "info"
					if  command_options.length > 1
						option = command_options[1]
						info(option)
					else
						list
						print"info about which Todo?:"
						todo = gets.chomp.downcase
						info(todo)
					end
					
				when "help"
					help
				when "count"
					count
				when "list"
					list
				when "version"
					version
				when "update"
					#help
				when "bye"
					bye
				else
					puts "Todo: invalid command *#{command}* (typing help will show vaild commands ) (RuntimeError)"
			end
		end
	end

=begin
	this method is called only by the constructor and not
    outside
=end
	def add_todo(task , completion_date)
		@task = task
		@@todo_base[task] = [completion_date]
		@@todo_base[task] << Time.new
		@@todo_count+=1
	end
=begin
	this method prints to the standard output i.e console
	the details of an activity(i.e an instance of the todos class
	in other words the object)
	Usage: this is called on the object by supplying the name of the
		   activity
=end
	def info(request)
		task = request.downcase.chomp
		case task
			when "all"
				puts "\tToDos info  all "
				puts "________________________________________"
				puts ""
				@@todo_base.each do |details| 
				specific_task , other_details  = details
				completion_date = other_details[0]
				input_date		= other_details[1]
				puts "\tToDos info #{specific_task}"
				puts "________________________________________"
				puts "ToDo            : #{specific_task}"
				puts "Completion Date : #{completion_date}"
				puts "Input Date      : #{input_date}"
				puts "________________________________________"
				end
				puts "________________________________________"
			else
				puts "\t\tToDos info";
				puts "________________________________________"
				completion_date , input_date = @@todo_base[task]
				puts "ToDo            : #{task}"
				puts "Completion Date : #{completion_date}"
				puts "Input Date      : #{input_date}"
				puts ""
				puts "________________________________________"
		end
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
		puts "________________________________________"
		for todo , _ in @@todo_base.to_a.sort!
			puts "#{todo}"
		end
		puts "________________________________________"
	end

	def new_task
		while true
			print "Task Name/Description:"
			task_name = gets.chomp!
			print "Completion Date:"
			completion_date = gets.chomp!
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
		Some useful Todo commands are:
		  commands      Documentation
		|*********|**********************************************|
		| add     |     Add a new Todo                           |
		|*********|**********************************************|
		| info    |     Display the full details of a task       |
		|*********|**********************************************|
		| count   |     Gives a total count of all Todos         |
		|*********|**********************************************|
		| list    |     List all Todos available                 |
		|*********|**********************************************|
		| update  |     Updates a Todo                           |
		|*********|**********************************************|
		| remove  |     Removes an entry completely from Todo    |
		|*********|**********************************************|
		| version |     Show the current Todo version            |
		|*********|**********************************************|
		| about   |     About Todo                               |
		|*********|**********************************************|
		| bye     |     Exit Todo                                |
		**********************************************************
		See 'help <command>' for information on a specific command.
		EOH
	end

	def bye
		exit
	end

	def version
		puts"1.0 beta"
	end

	def welcome_m
		print (<<-EOW)
		\t\t\t ☻  WELCOME ☻  
		Todos implements all the essential features of a collaborative task
		management app. Type help to get started
		EOW
	end
end
#Object initialization and  method / class method calls
ToDos.new

# update

# notifications
# database integration