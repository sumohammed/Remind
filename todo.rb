=begin
	A simple TODOs App
=end
require 'awesome_print'
require 'paint'

class Todo
  #class fields / or static fields
	@@todo_base = Hash.new
	@@todo_count = 0
=begin
	initialize each activity with the Activity Name and Completion Date
	automatically the activity is added with the time stamp i.e
	the activity entry date and time
=end
	def initialize
		start
	end

	private
	def mood
      a = []
      a << rand(257) 
      a << rand(257)
      a << rand(257)
      return a
	end
	def commandPrompt(command)

		print Paint[" "+command +":" ,:white,:bright]
	end
	def prompt?(question)

		print Paint[" "+question+":" ,:white,:bright]
	end
	def title(type="puts" ,colour ="#FFA11A",title)
		if type == "print"
			print Paint[" "+title,colour,:bright]
		else
			puts  Paint[" "+title,colour,:bright]
		end
	end
	def line

		puts Paint[" "+"________________________________________",:white,:bold]
	end
	def o_st

		puts ""
	end

	def content(type="puts",colour="#00AFFF",content)
		if type == "print"
			print Paint[" "+content, colour,:bright]
		else
			puts  Paint[" "+content, colour,:bright]
		end
	end

	def warn!(message="invalid", aux="err")
		if message == "exit"
		  print Paint[" "+"Are you sure of exiting Todo? Y|n:"   ,"#DE1515" ,:bright]
		elsif message == "invalid_exit_code"
		  puts Paint[" "+"Invalid exit code! *#{aux}* (ECError)" ,"#DE1515" ,:bright]
		elsif message == "invalid_option"
		  puts Paint[" "+"Invalid option! *#{aux}*    (OCError)" ,"#DE1515" ,:bright]
		else
		  puts Paint[" "+"Invalid command! *#{aux}* (typing help or -h will show vaild commands ) (CCError)" ,"#DE1515" ,:bright]
		end
	end

	def result?(result, colour="#FFAF00")
		puts Paint[" "+result,colour,:bright]
	end
	def header
		print Paint["
		\t\t\t\t ☻  WELCOME ☻ 
		\tTodo implements all the essential features of a collaborative\n\t\t\t\ttask management app.", mood ,:bright ,:underline]; 
		content("puts", "#fffff", "Type help or -h to get started" );
	end

	def start
		o_st
		welcome_m(mood)
		while true
			o_st
		    commandPrompt("Enter command ☻ " )
			command = input?
			command_options = command.split
			# test input
			case command_options[0]
				#ADD
				when "add"
					new_task
				when "a"
					new_task
				#INFO
				when "info"
					if  command_options.length > 1
						option = command_options[1]
						info(option)
					else
						list
						title("print","#38E22E","Info about which todo?:") ; todo = input?
						info(todo)
					end
				when "i"
					if  command_options.length > 1
						option = command_options[1]
						info(option)
					else
						list
						title("print","#38E22E","Info about which todo?:") ; todo = input?
						info(todo)
					end
				#HELP
				when "help"
					help
				when "-h"
					help

				#COUNT
				when "count"
					count
				when "c"
					count
				#LIST
				when "list"
					list
				when "l"
					list
				#ABOUT
				when "v"
					about
				#UPDATE
				when "update"
					#help
				#EXIT
				when "!"
					bye
				else
					warn!("command", command)
			end
		end
	end
=begin
	this method is called only by the constructor and not
    outside
=end
	def add_todo(task , completion_date)
		@@todo_base[task] = [completion_date , Time.new]
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
				o_st
				title("\t    Todo Info (all)")
				line
				@@todo_base.each do |details|
				specific_task , other_details  = details
				completion_date = other_details[0]
				input_date		= other_details[1]
				title("\t    Todo info(#{specific_task})")
				line
				content("ToDo            : #{specific_task}")
				content("Completion Date : #{completion_date}")
				content("Input Date      : #{input_date}")
				line
				end
				line
			else
				completion_date , input_date = @@todo_base[task]
				if completion_date == nil && input_date == nil
					result?("0 match : no such todo found!", "#EC1726")
					return
				else
					title("\t\tToDo Info #{task}")
					line
					content("ToDo            : #{task}")
					content("Completion Date : #{completion_date}")
					content("Input Date      : #{input_date}")
					o_st
					line
				end
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
		o_st
		line
		title("\t\tToDo Count")
		line
		result?("You have #{@@todo_count} task(s) currently in Todo","#047C37")
		line
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
		o_st ; line;
		title("\t\tToDos List")
		line
		for todo , _ in @@todo_base.to_a.sort!
			content("#{todo}")
		end
		line
	end

	def new_task
		while true
			o_st
			title("ADD TODO ☻ ")
			prompt?("Task Name")       ; task_name = input?
			prompt?("Completion Date") ; completion_date = input?
			add_todo(task_name , completion_date) ;response = add_new_task?
			   if response[0] == "n" or response[0] =="no"
				  line ; break
			elsif response[0] == "y" or response[0] == "yes"
				  line ; next
			else
				 warn!("invalid_option", response[0])
				return
			end
		end
	end

	def add_new_task?
		title("print","Add new todo? Y|n:"); response = input?.split
		return response
	end

	def help
		content("print","","
		Usage : <command>"); content("puts","#DD0202","[<args>]");
		content("puts", "","\t\tSome useful Todo commands are:
		 _______________________________________________________________
		|    Commands    |     Documentation                            |
		|****************|**********************************************|
		|     add ,a     |     Add a new Todo                           |
		|****************|**********************************************|
		|     info,i      |     Display the full details of a task      |
		|****************|**********************************************|
		|     count,c     |     Gives a total count of all Todos        |
		|****************|**********************************************|
		|     list,l      |     List all Todos available                |
		|****************|**********************************************|
		|    update,u    |     Updates a Todo                           |
		|****************|**********************************************|
		|    remove,r    |     Removes an entry completely from Todo    |
		|****************|**********************************************|
		|                |                                              |
		|****************|**********************************************|
		|       v        |     About Todo                               |
		|****************|**********************************************|
		| !(Exclamation) |     Exit Todo                                |
		*****************************************************************
		See 'help <command>' for information on a specific command.")
	end

	def bye
		warn!("exit") ; exit_status =  input?.split
		if  exit_status[0] == "n" or exit_status[0] =="no"
			line
		elsif  exit_status[0] == "y" or exit_status[0] == "yes"
			exit
		else
			warn!("invalid_exit_code", exit_status[0])
			return
		end
	end

	def about
		content("#F7E61D","1.0 beta")
	end
	def welcome_m(mood)
		header
	end

	def input?
		# always gets the input
		return gets.chomp.downcase
	end

end

#Object initialization and  method / class method calls
Todo.new
# update
# notifications
# database integration