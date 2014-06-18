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
    puts "                    with the project name next to each task emp history EID - Show completed"
    puts "                    tasks for employee with id=EID"
  end

  def client
    print ">>"
    input = gets.chomp
    action(input)
  end

  def action(input)
    cmd = input.split(" ").first.downcase
    args = input.split(" ")[1..-1]
    case cmd
    when "help"
      help
      client
    when "list"
      TM::Project.projects.each {|x| puts "#{x.id}: #{x.name}"}
      client
    when "create"
      name = args.join(" ")
      project = TM::Project.new(name)
      puts "#{project.name} created with project id: #{project.id}"
      client
    when "show"
      id = args[-1].to_i
      list = []
      TM::Project.projects.each do |x|
        list = x.get_incomplete_tasks if x.id == id
      end
      if(!(list.empty?))
        list.each {|x| puts "#{x.id}: #{x.description}"}
      else
        puts "This project has no remaining tasks"
      end
      client
    when "history"
      id = args[-1].to_i
      list = []
      TM::Project.projects.each do |x|
        list = x.get_complete_tasks if x.id == id
      end
      if(!(list.empty?))
        list.each {|x| puts "#{x.description}"}
      else
        puts "This project has no completed tasks"
      end
      client
    when "add"
      project_id = args[0].to_i
      priority = args[-1].to_i
      description = args[1..-2].join(" ")
      TM::Task.new(project_id, description, priority)
      puts "#{description} task created for project #{project_id} with a priority of #{priority}"
      client
    when "mark"
      task_id = args[-1].to_i
      TM::Project.mark_complete(task_id)
      puts "#{task_id} task id marked as completed"
      client
    when "exit"
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
