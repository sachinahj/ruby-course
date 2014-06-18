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
   project_id integer,
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
result = db.exec(command)
p result.values # [["1"]]

