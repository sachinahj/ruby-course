class TM::Client
  def initialize
  end

  def start
    puts "Welcome to Project Manager Lite"
    help
    client
  end

  private
  def help
    puts "Available Commands:"
    puts "  help - Show these commands again"
    puts "  project list - List all projects"
    puts "  project create NAME - Create a new project"
    puts "  project show PID - Show remaining tasks for project PID"
    puts "  project history PID - Show completed tasks for project PID"
    puts "  project employees PID - Show employees participating in this project"
    puts "  project recruit PID EID - Adds employee EID to participate in project PID"
    puts "  task create PID PRIORITY DESC - Add a new task to project PID"
    puts "  task assign TID EID - Assign task to employee"
    puts "  task mark TID - Mark task TID as complete"
    puts "  emp list - List all employees"
    puts "  emp create NAME - Create a new employee"
    puts "  emp show EID - Show employee EID and all participating projects"
    puts "  emp details EID - Show all remaining tasks assigned to employee EID, along"
    puts "                    with the project name next to each task"
    puts "  emp history EID - Show completed tasks for employee with id=EID"
  end

  def client
    print ">>"
    input = gets.chomp
    args = split_input(input)
    action(args)
  end

  def split_input(input)
    args = input.split(' ')

    return ["help", nil] if args[0] == "help"

    if args[0] == "task" && args[1] == "create"
      desc = [args[4..-1].join(" ")]
      array = args[0..3] + desc
      return array
    end

    if args[1] == "create"
      name = [args[2..-1].join(" ")]
      array = args[0..1] + name
      return array
    end

    return args
  end


  def action(args)
    case args[0]
    when "help"
      p 'in the help!'
      help
      client
    when "project"
      case args[1]
      when "list"
        p "in project list"
        TM.db.list_projects
      when "create"
        p "in project create"
        TM.db.create_project(args[2])
      when "show"
        p "in project show"
        TM.db.show_project_tasks(args[2])
      when "history"
        p "in project history"
        TM.db.show_completed_tasks(args[2])
      when "employees"
        p "in project employees"
        TM.db.show_project_employees(args[2])
      when "recruit"
        p "in project recruit"
        TM.db.recruit(args[2], args[3])
      else
        puts "Not a valid project input"
        client
      end
    when "task"
      case args[1]
      when "create"
        p "in task create"
        TM.db.create_task(args[2], args[3], args[4])
      when "assign"
        p "in task assign"
        TM.db.assign_task(args[2], args[3])
      when "mark"
        p "in task mark"
        TM.db.mark_task_complete(args[2])
      end
    when "emp"
      case args[1]
      when "list"
        p "in emp list"
        TM.db.list_employees
      when "create"
        p "in emp create"
        TM.db.create_employee(args[2])
      when "show"
        p "in emp show"
        TM.db.employee_info(args[2])
      when "details"
        p "in emp details" 
        TM.db.employee_details(args[2])
      when "history"
        p "in emp history"
        TM.db.employee_history(args[2])
      end
    when "exit" 
      puts "Good-bye"
      return
    when "quit"
      puts "Good-bye"
      return
    else
      puts "Not a valid input"
      client
    end
  end

end

# TM::Project.new("project 1")
# TM::Project.new("project 2")
# TM::Project.new("project 3")

# task1 = TM::Task.new(111, "Task 1", 3)
# task2 = TM::Task.new(111, "Task 2", 3)
# task3 = TM::Task.new(111, "Task 3", 1)
# TM::Task.mark_complete(task1.id)

# system('clear')
TM::Client.new.start
