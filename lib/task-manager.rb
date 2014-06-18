require 'pg'

db = PG.connect(host: 'localhost', dbname: 'task_manager_database')

command = <<-SQL
CREATE TABLE employees(
   id SERIAL,
   name text,
   PRIMARY KEY( id )
);

CREATE TABLE tasks(
   id SERIAL,
   description text,
   priority integer,
   complete boolean,
   PRIMARY KEY( id )
);

CREATE TABLE projects(
   id SERIAL,
   name text,
   PRIMARY KEY( id )
);

CREATE TABLE projects_employees(
   id SERIAL,
   project_id integer,
   employee_id integer,
   PRIMARY KEY( id )
);

CREATE TABLE tasks_employees(
   id SERIAL,
   task_id integer,
   employee_id integer,
   PRIMARY KEY( id )
);

CREATE TABLE projects_tasks(
   id SERIAL,
   project_id integer,
   task_id integer,
   PRIMARY KEY( id )
);
SQL


# command = <<-SQL

# SELECT * FROM users;

# SQL

result = db.exec(command)
p result.values # [["1"]]


# Create our module. This is so other files can start using it immediately
module TM

  class DB
    def create_task(data)

    end
  end

  def self.db
    @__db__ ||= DB.new
  end

end

# Require all of our project files
require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'
# require_relative 'task-manager/client2.rb'
