
class TM::Task
  attr_reader :project_id, :description, :priority, :id, :date
  attr_accessor :complete
  @@counter = 11111
  def initialize(project_id, description, priority)
    @project_id = project_id
    @description = description
    @priority = priority

    @date = Time.now
    @complete = false
    @id = @@counter
    @@counter += 1

    TM::Project.add_task(@project_id, self)
  end

  def self.mark_complete(task_id)
    TM::Project.mark_complete(task_id)
  end

end
