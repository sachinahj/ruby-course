require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  before do
    @project = TM::Project.new("Tasks")
    @project_id = @project.id
    @description = "Compile list of all clients"
    @priority = 1
    @task = TM::Task.new(@project_id, @description, @priority)
  end

  it "has a project ID" do
    expect(@task.project_id).to eq(@project_id)
  end

  it "has a description" do
    expect(@task.description).to eq(@description)
  end

  it "has a priority number" do
    expect(@task.priority).to eq(@priority)
  end

  it "has a task ID" do
    expect(@task.id).to_not eq(nil)
  end

  it "can be marked as completed, specified by its id" do
    TM::Task.mark_complete(@task.id)
    expect(@project.tasks.first.complete).to eq(true)
  end

end
