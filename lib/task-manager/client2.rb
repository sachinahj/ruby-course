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
      # p 'in the help!'
      help
      client
    when "project"
      case args[1]
      when "list"
        # p "in project list"
        result = TM.db.list_projects
        puts "--Projects List--"
        puts "PID, Project Name"
        result.each do |x|
          puts "#{x[0]}, #{x[1]}"
        end
        client
      when "create"
        # p "in project create"
        result = TM.db.create_project(args[2])
        pid = result[0][0]
        name = result[0][1]
        puts "--Project Created--"
        puts "Project ID: #{pid}"
        puts "Project Name: #{name}"
        client
      when "show"
        # p "in project show"
        result = TM.db.show_project_tasks(args[2])
        project = result.shift
        project_id = project[0]
        project_name = project[1]
        puts "--Remaining Task for #{project_name}(PID: #{project_id})--"
        puts "TID, PID, Description, Priority"
        result.each do |x|
          puts "#{x[0]}, #{x[1]}, #{x[2]}, #{x[3]}"
        end
        client
      when "history"
        # p "in project history"
        result = TM.db.show_completed_tasks(args[2])
        project = result.shift
        project_id = project[0]
        project_name = project[1]
        puts "--Completed Task for #{project_name}(PID: #{project_id})--"
        puts "TID, PID, Description, Priority"
        result.each do |x|
          puts "#{x[0]}, #{x[1]}, #{x[2]}, #{x[3]}"
        end
        client
      when "employees"
        p "in project employees"
        TM.db.show_project_employees(args[2])
      when "recruit"
        # p "in project recruit"
        result = TM.db.recruit(args[2], args[3])
        pid = result[0][0]
        pname = result[0][1]
        eid = result[1][0]
        ename = result[1][1]
        if result[2] != nil
          puts "Employee: #{ename}(#{eid}) added to Project: #{pname}(#{pid})"
        else 
          puts "Employee not added to project."
        end
      else
        puts "Not a valid project input"
        client
      end
    when "task"
      case args[1]
      when "create"
        # p "in task create"
        result = TM.db.create_task(args[2], args[3], args[4])
        tid = result[0][0]
        pid = result[0][1]
        description = result[0][2]
        priority = result[0][3]
        complete = result[0][4]
        puts "--Task Created--"
        puts "Task ID: #{tid}"
        puts "Project ID: #{pid}"
        puts "Description: #{description}"
        puts "Priority: #{priority}"
        client
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
        # p "in emp list"
        result = TM.db.list_employees
        puts "--Employee List--"
        puts "ID, Employee Name"
        result.each do |x|
          puts "#{x[0]}, #{x[1]}"
        end
        client
      when "create"
        # p "in emp create"
        result = TM.db.create_employee(args[2])
        eid = result[0][0]
        name = result[0][1]
        puts "--Employee Created--"
        puts "Employee ID: #{eid}"
        puts "Employee Name: #{name}"
        client
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
