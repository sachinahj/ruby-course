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
    puts "  list - List all projects"
    puts "  create NAME - Create a new project with name = NAME"
    puts "  show PID - Show remaining tasks for project with id=PID"
    puts "  history PID - Show completed tasks for project with id=PID"
    puts "  add PID DESC PRIORITY- Add a new task to project with id=PID"
    puts "  mark TID - Mark task with id=TID as complete"
  end

  def client
    print "_"
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

system('clear')
TM::Client.new.start
