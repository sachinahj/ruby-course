# Create our module. This is so other files can start using it immediately
require 'pg'

module TM

  class DB

    def initialize
      @db = PG.connect(host: 'localhost', dbname: 'task_manager_db')
    end

    def list_projects
      command = <<-SQL
        SELECT * FROM projects;
      SQL

      result = @db.exec(command)
      result.values
    end
    def create_project(name)

      command = <<-SQL
        INSERT INTO projects( name )
        VALUES ( '#{name}' )
        returning *;
      SQL

      result = @db.exec(command)
      result.values
    end
    def show_project_tasks(pid)

      command = <<-SQL
        SELECT * FROM projects WHERE id='#{pid}';
      SQL
      result1 = @db.exec(command)
      # p result1.values

      command = <<-SQL
        SELECT * FROM tasks WHERE project_id='#{pid}' AND complete='false';
      SQL

      result2 = @db.exec(command)
      # p result2.values

      result = result1.values + result2.values
      # p result
    end
    def show_completed_tasks(pid)

      command = <<-SQL
        SELECT * FROM projects WHERE id='#{pid}';
      SQL
      result1 = @db.exec(command)
      # p result1.values

      command = <<-SQL
        SELECT * FROM tasks WHERE project_id='#{pid}' AND complete='true';
      SQL

      result2 = @db.exec(command)
      # p result2.values

      result = result1.values + result2.values
      # p result
    end
    def show_project_employees(pid)

      command = <<-SQL
        SELECT * FROM projects_employees WHERE project_id='#{pid}';
      SQL

      result = @db.exec(command)
      p result.values
    end
    def recruit(pid, eid)

      command = <<-SQL
        SELECT * FROM projects WHERE id='#{pid}';
      SQL
      result1 = @db.exec(command)
      # p result1.values

      command = <<-SQL
        SELECT * FROM employees WHERE id='#{eid}'
      SQL

      result2 = @db.exec(command)
      # p result2.values

      command = <<-SQL
        INSERT INTO projects_employees( project_id, employee_id )
        VALUES ( '#{pid}', '#{eid}' )
        returning *;
      SQL

      result3 = @db.exec(command)
      # p result3.values

      result = result1.values + result2.values + result3.values
      # p result
    end

    def create_task (pid, priority, description)

      command = <<-SQL
        INSERT INTO tasks( project_id, priority, description, complete)
        VALUES ( '#{pid}', '#{priority}', '#{description}', 'false' )
        returning *;
      SQL

      result = @db.exec(command)
      result.values

    end
    def assign_task(tid, eid)

      command = <<-SQL
        INSERT INTO tasks_employees( task_id, employee_id )
        VALUES ( '#{tid}', '#{eid}' )
        returning *;
      SQL

      result = @db.exec(command)
      p result.values
    end
    def mark_task_complete(tid)

      command = <<-SQL
        
      SQL

      result = @db.exec(command)
      p result.values
    end
    def list_employees

      command = <<-SQL
        SELECT * FROM employees;
      SQL

      result = @db.exec(command)
      result.values
    end
    def create_employee(name)

      command = <<-SQL
        INSERT INTO employees( name )
        VALUES ( '#{name}' )
        returning *;
      SQL

      result = @db.exec(command)
      result.values
    end
    def employee_info(eid)

      command = <<-SQL
        SELECT * FROM employees WHERE id='#{eid}';
      SQL

      result = @db.exec(command)
      p result.values
    end
    def employee_details(eid)

      command = <<-SQL
        SELECT * FROM employees WHERE id='#{eid}';
      SQL

      result = @db.exec(command)
      p result.values
    end
    def employee_history(eid)

      command = <<-SQL
        SELECT * FROM employees WHERE id='#{eid}';
      SQL

      result = @db.exec(command)
      p result.values
    end
  end

  def self.db
    @__db__ ||= DB.new
  end

end

# projects = TM.db.list_projects
# project = TM.db.create_project(NAME)
# tasks = TM.db.show_project_tasks(PID)
# history = TM.db.show_completed_tasks(PID)
# employees = TM.db.show_project_employees(PID)
# recruit = TM.db.recruit(PID EID)

# task = TM.db.create_task(PID PRIORITY DESC)
# task = TM.db.assign_task(TID EID)
# task = TM.db.mark_task_complete(TID)

# employees = TM.db.list_employees
# employee = TM.db.create_employee(NAME)
# projects = TM.db.employee_info





# Require all of our project files
require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'
require_relative 'task-manager/client2.rb'
# require_relative 'tables_initializer.rb'





