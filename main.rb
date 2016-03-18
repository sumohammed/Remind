class ToDoApp
	@@activity = Hash.new

	def initialize(completion_date , activity)
		@current_date = Time.new
		set_activity(completion_date , activity)
	end
	# this method sets an activity together with a date for reminder
	def set_activity(completion_date , activity)
		@@activity[completion_date] = activity
	end

	def get_activity
		puts "Time is due for #{@@activity}"
	end

	def remove_activity(activity)
		
	end
end


RubyClass =  ToDoApp.new("Activity_1" ,["RubyClass","21-03-2016"])
RubyClass.set_activity("Activity_2" ,["PythonClass","21-03-2016"])
# PythonClass =  ToDoApp.new()
RubyClass.get_activity
# PythonClass.get_activity
