require_relative 'base'
require_relative 'utils'

class Remind < Utils::Engine
  def initialize
    check_broken
  end

  private

  def login
    loop do
      count = 0
      # request user login credentials
      o_st; title("Remind ☻  ~~~> (!) to exit")
      commandPrompt("Password for #{Etc.getlogin}")
      pw = input
      if pw == '!'
        bye
      elsif pw == '!@#'
        clear; admin
      else
        # (P-S-H)-IN THE SELECT CONTEXT
        handler("SELECT * FROM user WHERE us = '#{Etc.getlogin}' and pw = '#{pw.split[0]}'").each do |_row|
          count += 1
        end
        case count
        when 1
          clear
          start_application
        else
          content('puts', '#E30000', 'Invalid login credentials , please try again')
          next
          end
        end
    end
  end

  def admin
    loop do
      count = 0
      # request user login credentials
      o_st; title("Remind ☻  ~~~> (!) to exit")
      commandPrompt('Password for [admin]')
      pw = input
      if pw == '!'
        bye
      elsif pw == 'u'
        clear; check_broken
      else
        # (P-S-H)-IN THE SELECT CONTEXT
        handler("SELECT * FROM user WHERE us = 'admin' and pw = '#{pw.split[0]}'").each do |_row|
          count += 1
        end
        case count
        when 1
          clear
          start_application
        else
          content('puts', '#E30000', 'Invalid login credentials , please try again')
          next
        end
        end
    end
  end
  end

def start_application
  o_st
  welcome_m
  loop do
    o_st
    commandPrompt("Enter command ☻ ")
    command = input
    command_options = command.split
    # test input
    case command_options[0]
    # ADD
    when 'add'
      new_task
    when 'a'
      new_task
    # INFO
    when 'info'
      if command_options.length > 1
        option = command_options[1]
        info(option)
      else
        list
        title('print', '#38E22E', 'Info about which remind?:'); remind = input
        info(remind)
        end
    when 'i'
      if command_options.length > 1
        option = command_options[1]
        info(option)
      else
        list
        title('print', '#38E22E', 'Info about which remind?:'); remind = input
        info(remind)
      end
    # HELP
    when 'help'
      help
    when '-h'
      help

    # COUNT
    when 'count'
      count
    when 'c'
      count
    # LIST
    when 'list'
      list
    when 'l'
      list
    when 'r'
      if command_options.length > 1
        option = command_options[1]
        remove(option)
      else
        list
        title('print', '#38E22E', 'remove which remind ?:'); task = input
        remove(task)
      end
    # ABOUT
    when 'v'
      about
    # UPDATE
    when 'update'
    # help
    # EXIT
    when '!'
      bye
    when 'clear'
      clear
    when '@'
      system('clear')
    else
      warn('command', command)
    end
  end
  end

# 	this method is called only by the constructor and not
#     outside
def add_remind(task, completion_date, task_description)
  time = Time.new
  handler('insert', "INSERT INTO task (tn , tind, tcd , td) VALUES ('#{task}' ,'#{time}', '#{completion_date}' , '#{task_description}')")
  end

# 	this method prints to the standard output i.e console
# 	the details of an activity(i.e an instance of the reminds class
# 	in other words the object)
# 	Usage: this is called on the object by supplying the name of the
# 	activity
def remove(t)
  task = t.downcase.chomp
  case task
  when 'all'
    warn('removal'); delete_option = input.split
    if     delete_option[0] == 'n' || delete_option[0] == 'no'
      line
    elsif  delete_option[0] == 'y' || delete_option[0] == 'yes'
      clear; delete_all!
      list
    else
      warn('invalid_removal_option', delete_option[0])
      return
    end
  else
    warn('removal'); delete_option = input.split
    if     delete_option[0] == 'n' || delete_option[0] == 'no'
      line
    elsif  delete_option[0] == 'y' || delete_option[0] == 'yes'
      clear; delete_task(task)
      list
    else
      warn('invalid_removal_option', delete_option[0])
      return
    end
  end
  end

def delete_all!
  handler('delete', 'DELETE  FROM task ')
  list
  end

def delete_task(task)!
     handler("DELETE FROM task WHERE tn = '#{task}'")
  end

def info(request)
  task = request.downcase.chomp
  case task
  when 'all'
    clear
    o_st
    title("\t    Remind Info (all)")
    line
    handler('SELECT * FROM task').each do |row|
      title("\t    Remind Info(#{row[1]})")
      line
      content("Remind          : #{row[1]}")
      content("Entry Date      : #{row[2]}")
      content("Completion Date : #{row[3]}")
      o_st
      # type="puts",colour="#00AFFF",content,underline="true"
      title('puts', '#E6E116', 'Description:')
      content((row[4]).to_s)
      line
    end
  else
    count = 0
    rows = handler("SELECT * FROM task WHERE tn = '#{task}'")
    rows.each { count += 1 }
    case count
    when 0
      line
      result('0 match, no such remind found!', '#EC1726')
      line
      return
    else
      count = 0
      handler("SELECT * FROM task WHERE tn = '#{task}'").each do |r|
        line
        title("\t    Remind Info(#{r[1]}->#{count += 1})")
        line
        content("Remind          : #{r[1]}")
        content("Entry Date      : #{r[2]}")
        content("Completion Date : #{r[3]}")
        o_st
        title('puts', '#E6E116', 'Description:')
        content((r[4]).to_s)
        line
      end
      end
    result("#{count} matche(s) ", '#F46E15')
    line
  end
  end

def count
  o_st; line
  title("\t\tRemind Count")
  line
  count = 0; handler('SELECT * FROM task ').each do |_row|
               count += 1
             end
  case count
  when 0
    result(' Am free Yipeeee, nothing to remind you of!', '#047C37')
  else
    result(" You have #{count} tasks currently in Remind", '#047C37')
  end
  line
  end

def list
  clear; o_st; line
  title("\t\tremind List")
  line
  handler('SELECT * FROM task').each do |row|
    content((row[1]).to_s)
  end
  line
  end

def new_task
  loop do
    o_st
    title("ADD REMIND ☻ + ")
    prompt('Task Name'); task_name = input
    prompt('Completion Date'); completion_date = input
    prompt('Task Description'); task_description = input
    add_remind(task_name, completion_date, task_description); response = add_new_task
    if response[0] == 'n' || response[0] == 'no'
      line; break
    elsif response[0] == 'y' || response[0] == 'yes'
      line; next
    else
      warn('invalid_option', response[0])
      return
    end
  end
  end

def add_new_task
  title('print', 'Add new remind? Y|n:'); response = input.split
  response
  end

def clear
  system('clear')
  end

def bye
  warn('exit'); exit_status = input.split
  if exit_status[0] == 'n' || exit_status[0] == 'no'
    line
  elsif exit_status[0] == 'y' || exit_status[0] == 'yes'
    clear; exit
  else
    warn('invalid_exit_code', exit_status[0])
    return
  end
  end

def about
  content('#F7E61D', '1.0 beta')
  end

def welcome_m
  header
  end

def input
  # always gets the input
  gets.chomp.downcase
  end
Remind.new
