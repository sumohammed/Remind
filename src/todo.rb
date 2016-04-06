=begin
	A simple TODOs App
=end
# require "rubygems"
require 'paint'
require_relative 'base'
class Todo
=begin
	initialize each activity with the Activity Name and Completion Date
	automatically the activity is added with the time stamp i.e
	the activity entry date and time
=end
	def initialize
		check_broken
	end

	private
	def mood
      a = []
      a << rand(257)
      a << rand(257)
      a << rand(257)
      return a
	end

	def check_broken
		file = File.open(".todo.txt") if File::exists?(".todo.txt")
		if file == nil  then
		   f_encounter
		   file = File.new(".todo.txt","a+")
		   file.syswrite("broken\n") ;file.close;
		   clear ; login
		else
			logins = file.sysread(6) ;file.close;
			if logins == "broken" then
				login
			end
		end
	end

	def login
		while true
			count = 0
		    # request user login credentials
		    o_st ;  title("Todo ☻  ~~~> (!) to exit")
		 	commandPrompt("Password for #{Etc.getlogin}")
		 	pw =input?
		 	if pw == "!"
			bye
			elsif pw == "!@#"
				clear; admin;
			else
			 	#(P-S-H)-IN THE SELECT CONTEXT
			 	handler("SELECT * FROM user WHERE us = '#{Etc.getlogin}' and pw = '#{pw.split[0]}'").each{ |row|
			 	  count+=1
			 	}
			 	case count
			 	   	when 1
			 	   		clear
			 	   		start_application
			 	   	else
			 	   	    content("puts","#E30000","Invalid login credentials , please try again")
			 	   		next
			 	end
			end
		end
	end

	def admin
		while true
			count = 0
		    # request user login credentials
		    o_st ;  title("Todo ☻  ~~~> (!) to exit")
		 	commandPrompt("Password for [admin]")
		 	pw =input?
		 	if pw == "!"
			   	bye
			elsif pw == "u"
				  clear ; check_broken
			else
			 	#(P-S-H)-IN THE SELECT CONTEXT
			 	handler("SELECT * FROM user WHERE us = 'admin' and pw = '#{pw.split[0]}'").each{ |row|
			 	  count+=1
			 	}
			 	case count
			 	   	when 1
			 	   		clear
			 	   		start_application
			 	   	else
			 	   	    content("puts","#E30000","Invalid login credentials , please try again")
			 	   		next
			 	end
			end
		end
	end
	end

	def commandPrompt(command)

		print Paint[" ".concat(command).concat(':'),:white,:bright]
	end
	def prompt?(question)

		print Paint[" ".concat(question).concat(":") ,:white,:bright]
	end
	def title(type="puts" ,colour ="#FFA11A",title)
		if type == "print"
			print Paint[" ".concat(title),colour,:bright]
		else
			puts  Paint[" ".concat(title),colour,:bright]
		end
	end
	def line

		puts Paint[" "+"______________________________________________",:white,:bold]
	end
	def o_st

		puts ""
	end

	def content(type="puts",colour="#00AFFF",content)
		if  type == "print"
			print Paint[" "+content, colour,:bright]
		else
			puts  Paint[" "+content, colour,:bright]
		end
	end

	def warn!(message="invalid", aux="err")
		if message == "exit"
		  print Paint[" "+"Are you sure of exiting Todo? Y|n:"    , "#DE1515" ,:bright]
		elsif message == "removal"
		  print Paint[" "+"Are you sure of deleting the selected task? Y|n:"    , "#DE1515" ,:bright]
		elsif message == "invalid_exit_code"
		  puts  Paint[" "+"Invalid exit code! *#{aux}* (ECError)" , "#DE1515" ,:bright]
		elsif message == "invalid_removal_option"
		  puts  Paint[" "+"Invalid delete option ! *#{aux}* (DOError)" , "#DE1515" ,:bright]
		elsif message == "invalid_option"
		  puts  Paint[" "+"Invalid option! *#{aux}*    (OCError)" , "#DE1515" ,:bright]
		elsif message =="matcherror"
		  puts  Paint[" "+"Passwords do not match! (MError)"      , "#DE1515" ,:bright]
		else
		  puts  Paint[" "+"Invalid command! *#{aux}* (typing help or -h will show vaild commands ) (CCError)" ,"#DE1515" ,:bright]
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

	def start_application
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
				when "r"
					if  command_options.length > 1
						option = command_options[1]
						remove(option)
					else
						list
						title("print","#38E22E","remove which todo?:") ; task = input?
						remove(task)
					end
				#ABOUT
				when "v"
					about
				#UPDATE
				when "update"
					#help
				#EXIT
				when "!"
					bye
				when "clear"
					system("clear")
				when "@"
					system("clear")
				else
					warn!("command", command)
			end
		end
	end
=begin
	this method is called only by the constructor and not
    outside
=end
	def add_todo(task , completion_date , task_description)
		time = Time.new
		handler("insert", "INSERT INTO task (tn , tind, tcd , td) VALUES ('#{task}' ,'#{time}', '#{completion_date}' , '#{task_description}')")
	end
=begin
	this method prints to the standard output i.e console
	the details of an activity(i.e an instance of the todos class
	in other words the object)
	Usage: this is called on the object by supplying the name of the
	activity
=end
	def remove(t)
		task = t.downcase.chomp
		case task
			when "all"
				  warn!("removal") ; delete_option = input?.split
				  if     delete_option[0] == "n" or delete_option[0] == "no"
				         line
				  elsif  delete_option[0] == "y" or delete_option[0] == "yes"
					     clear ; delete_all!;
					     list
				  else
					 	 warn!("invalid_removal_option", delete_option[0])
					 	 return
				  end
			else
				  warn!("removal") ; delete_option = input?.split
				  if     delete_option[0] == "n" or delete_option[0] == "no"
				         line
				  elsif  delete_option[0] == "y" or delete_option[0] == "yes"
					     clear ;  delete_task(task);
					     list
				  else
					 	 warn!("invalid_removal_option", delete_option[0])
					 	 return
				  end
		end
	end


	def delete_all!
	 	handler("delete" , "DELETE  FROM task ")
	 	list
	end

	def delete_task(task)!
		 handler("DELETE FROM task WHERE tn = '#{task}'")
	end

	def info(request)
		task = request.downcase.chomp
		case task
			when "all"
				clear
				o_st
				title("\t    Todo Info (all)")
				line
				handler("SELECT * FROM task").each do |row|
				title("\t    Todo Info(#{row[1]})")
				line
				content("Todo            : #{row[1]}")
				content("Entry Date      : #{row[2]}")
				content("Completion Date : #{row[3]}")
				o_st
				# type="puts",colour="#00AFFF",content,underline="true"
				title("puts","#E6E116","Description:")
				content("#{row[4]}")
				line
				end
			else
				count = 0
				rows = handler("SELECT * FROM task WHERE tn = '#{task}'")
				rows.each{count+=1}
				case count
					when 0
						line
						result?("0 match, no such todo found!", "#EC1726")
						line
						return
					else
						count = 0
						handler("SELECT * FROM task WHERE tn = '#{task}'").each do |r|
						line
						title("\t    Todo Info(#{r[1]}->#{count+=1})")
						line
						content("Todo            : #{r[1]}")
						content("Entry Date      : #{r[2]}")
						content("Completion Date : #{r[3]}")
						o_st
						title("puts","#E6E116","Description:")
						content("#{r[4]}")
						line
						end
					end
						result?("#{count} matche(s) ", "#F46E15")
						line
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
		o_st; line;
		title("\t\tTodo Count")
		line
		count = 0 ; handler("SELECT * FROM task ").each do |row|
			count+=1
		end
			case count
			when 0
				result?("You have #{count} task currently in Todo","#047C37")
			else
			    result?("You have #{count} tasks currently in Todo","#047C37")
			end
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
		clear ; o_st ; line;
		title("\t\tTodo List")
		line
		handler("SELECT * FROM task").each  do |row|
			content("#{row[1]}")
		end
		line
	end

	def new_task
		while true
			o_st
			title("ADD A TODO ☻ + ")
			prompt?("Task Name")       ; task_name = input?
			prompt?("Completion Date") ; completion_date = input?
			prompt?("Task Description"); task_description = input?
			add_todo(task_name , completion_date, task_description) ;response = add_new_task?
			    if    response[0] == "n" or response[0] =="no"
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
	def clear
		system("clear")
	end

	def help
		clear
		content("print","","
		Usage : <command>"); content("puts","#DD0202","[<args>]");
		content("puts", "","\t\tSome useful Todo commands are:
		 _______________________________________________________________
		|    Commands    |     Documentation                            |
		|****************|**********************************************|
		|     add ,a     |     Add a new Todo                           |
		|****************|**********************************************|
		|     info,i     |     Display the full details of a task       |
		|****************|**********************************************|
		|     count,c    |     Gives a total count of all Todos         |
		|****************|**********************************************|
		|     list,l     |     List all Todos available                 |
		|****************|**********************************************|
		|    update,u    |     Updates a Todo                           |
		|****************|**********************************************|
		|    remove,r    |     Removes an entry completely from Todo    |
		|****************|**********************************************|
		|    clear, @    |     Clear terminal screen                    |
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
			clear ; exit;
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

	def f_encounter
		content("puts","#FFAF00","Hello ☻ , #{Etc.getlogin} Thanks for using Todo, Track your tasks with a simple todo list.\n Get things done for personal productivity and time management. \n kindly create a password for continue usage or type (!) to exit out of here.")
		while true
				o_st; commandPrompt("Password"); pw =input?;
				     if pw == "!"
						bye
					 elsif pw =="!@#"
						clear ; admin ;
					 else
						o_st ; commandPrompt("Confirm Password"); cpw =input?;
		 					if cpw.eql?(pw) then
								handler("insert", "INSERT INTO user ( us, pw ) VALUES ('#{Etc.getlogin}' , '#{pw}')")
								break
							else
								warn!("matcherror")
								next
						end
		 			end
		end
	end
	def input?
		# always gets the input
		return gets.chomp.downcase
	end

	def on_demand_connection
		# gets as a connection to our data source as and
		# when need.
		#solved bug
		# @@sth ||= Base::MyBase.new.make_connection
		# return @@sth
		sth = Base::MyBase.new.make_connection
		return sth
	end

	# polymorphous statement handler (P-S-H)
	def handler(statement_type ="select", sql_query)
		# prepare connection to the datasource for sauthentication
	    osth = on_demand_connection # do something with the connection
		case statement_type
		  when "insert"
			 osth.do(sql_query)
		  when "update"
			osth.do(sql_query)
		  when "delete"
			osth.do(sql_query)
		  else
			result_set = osth.select_all(sql_query)
			#pls before you leave ensure that connection to data source is terminated
			return result_set
		end
		ensure
		  # ok i will ensure connection is no more thank you!
		  osth.disconnect if osth
	end
Todo.new
# update
# notifications
# database integration -halfway