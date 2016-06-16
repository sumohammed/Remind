require 'paint'
require_relative 'base'
module Utils
  class Engine
    def check_broken
      file = File.open('.remind.txt') if File.exist?('.remind.txt')
      if file.nil?
        f_encounter
        file = File.new('.remind.txt', 'a+')
        file.syswrite("broken\n")
        file.close
        clear
        login
      else
        logins = file.sysread(6)
        file.close
        login if logins == 'broken'
      end
   end

    def f_encounter
      content('puts', '#FFAF00', "Hello , #{Etc.getlogin} Thanks for using Remind ☻ , Track your tasks with a simple remind list.\n Get things done for personal productivity and time management. \n kindly create a password for continue usage or type (!) to exit out of here.")
      loop do
        o_st
        commandPrompt('Password')
        pw = input
        if pw == '!'
          bye
        elsif pw == '!@#'
          clear
          admin
        else
          o_st
          commandPrompt('Confirm Password')
          cpw = input
          if cpw.eql?(pw)
            handler('insert', "INSERT INTO user ( us, pw ) VALUES ('#{Etc.getlogin}' , '#{pw}')")
            break
          else
            warn('matcherror')
            next
         end
        end
      end
   end

    def commandPrompt(command)
      print Paint[' '.concat(command).concat(':'), :white, :bright]
    end

    def prompt(question)
      print Paint[' '.concat(question).concat(':'), :white, :bright]
    end

    def title(type = 'puts', colour = '#FFA11A', title)
      if type == 'print'
        print Paint[' '.concat(title), colour, :bright]
      else
        puts Paint[' '.concat(title), colour, :bright]
     end
    end

    def line
      puts Paint[' ' + '______________________________________________', :white, :bold]
    end

    def o_st
      puts ''
    end

    def content(type = 'puts', colour = '#00AFFF', content)
      if type == 'print'
        print Paint[' ' + content, colour, :bright]
      else
        puts  Paint[' ' + content, colour, :bright]
     end
    end

    def warn(message = 'invalid', aux = 'err')
      if message == 'exit'
        print Paint[' ' + 'Are you sure of exiting Remind? Y|n:', '#DE1515', :bright]
      elsif message == 'removal'
        print Paint[' ' + 'Are you sure of deleting the selected task? Y|n:', '#DE1515', :bright]
      elsif message == 'invalid_exit_code'
        puts  Paint[' ' + "Invalid exit code! *#{aux}* (ECError)", '#DE1515', :bright]
      elsif message == 'invalid_removal_option'
        puts  Paint[' ' + "Invalid delete option ! *#{aux}* (DOError)", '#DE1515', :bright]
      elsif message == 'invalid_option'
        puts  Paint[' ' + "Invalid option! *#{aux}*    (OCError)", '#DE1515', :bright]
      elsif message == 'matcherror'
        puts  Paint[' ' + 'Passwords do not match! (MError)', '#DE1515', :bright]
      else
        puts  Paint[' ' + "Invalid command! *#{aux}* (typing help or -h will show vaild commands ) (CCError)", '#DE1515', :bright]
     end
    end

    def result(result, colour = '#FFAF00')
      puts Paint[' ' + result, colour, :bright]
    end

    def header
      # def title(type="puts" ,colour ="#FFA11A",title)
      title('puts', "REMIND ☻")
      content('puts', '#fffff', 'Type help or -h to get started')
    end

    def help
      clear
      content('print', '', "
  		Usage : <command>")
      content('puts', '#DD0202', '[<args>]')
      content('puts', '', "\t\tSome useful Remind commands are:
  		 _______________________________________________________________
  		|    Commands    |     Documentation                            |
  		|****************|**********************************************|
  		|     add ,a     |     Add a new Remind                         |
  		|****************|**********************************************|
  		|     info,i     |     Display the full details of a task       |
  		|****************|**********************************************|
  		|     count,c    |     Gives a total count of all Reminds       |
  		|****************|**********************************************|
  		|     list,l     |     List all Reminds available               |
  		|****************|**********************************************|
  		|    update,u    |     Updates a Remind                         |
  		|****************|**********************************************|
  		|    remove,r    |     Removes an entry completely from Remind  |
  		|****************|**********************************************|
  		|    clear, @    |     Clear terminal screen                    |
  		|****************|**********************************************|
  		|       v        |     About Remind                             |
  		|****************|**********************************************|
  		| !(Exclamation) |     Exit Remind                              |
  		*****************************************************************
      See 'help <command>' for information on a specific command.").freeze
   end

    def on_demand_connection
      Base::MyBase.new.make_connection
    end

    # polymorphous statement handler (P-S-H)
    def handler(statement_type = 'select', sql_query)
      # prepare connection to the datasource for authentication
      osth = on_demand_connection # do something with the connection
      case statement_type
      when 'insert'
        osth.do(sql_query)
      when 'update'
        osth.do(sql_query)
      when 'delete'
        osth.do(sql_query)
      else
        result_set = osth.select_all(sql_query)
        # pls before you leave ensure that connection to data source is terminated
        return result_set
      end
    ensure
      # ok i will ensure connection is no more thank you!
      osth.disconnect if osth
    end
 end
end
