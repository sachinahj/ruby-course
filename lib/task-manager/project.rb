
class TM::Project
  attr_reader :name, :id, :tasks
  @@counter = 0
  @@projects =[]
  def initialize(name)
    @name = name
    @id = @@counter
    @@counter += 1
    @tasks = []
    @@projects << self
  end

  def get_complete_tasks
    list = []
    @tasks.each do |x|
      if x.complete == true
        list.push(x)
      end
    end
    list = list.sort {|x,y| y.date <=> x.date}
    # p list
    # list = list.reverse
  end

  def get_incomplete_tasks
    list = []
    @tasks.each do |x|
      if x.complete == false
        list.push(x)
      end
    end
    list = list.sort {|x,y| [x.priority, y.date] <=> [y.priority, x.date]}
    # p list
  end

  def self.add_task(project_id, task)
    @@projects.each do |x|
      if x.id == project_id
        x.tasks << task
      end
    end
  end
  def self.mark_complete(task_id)
    @@projects.each do |x|
      x.tasks.each do |y|
        if y.id == task_id
          y.complete = true 
        end
      end
    end
  end

end
