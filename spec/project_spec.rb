require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "must have a name" do
    project = TM::Project.new("Whatever")
    expect(project.name).to eq("Whatever")
  end

  it "has a project ID" do
    project = TM::Project.new("RUI")
    expect(project.id).to_not eq(nil)
  end

  it "can retrieve a list of all complete tasks, sorted by creation date" do
    project = TM::Project.new("Test")
    project_id = project.id

    # expect(Time).to receive(:now).and_return(Time.parse("June 7 2014"))
    Time.stub(:now).and_return(Time.parse("June 7 2014"))
    task1 = TM::Task.new(project_id, "Task 1", 3)
    task1_id = task1.id

    # expect(Time).to receive(:now).and_return(Time.parse("June 8 2014"))
    Time.stub(:now).and_return(Time.parse("June 8 2014"))
    task2 = TM::Task.new(project_id, "Task 2", 1)
    task2_id = task2.id

    # expect(Time).to receive(:now).and_return(Time.parse("June 11 2014"))
    Time.stub(:now).and_return(Time.parse("June 9 2014"))
    task4 = TM::Task.new(project_id, "Task 4", 2)
    task4_id = task4.id

    # expect(Time).to receive(:now).and_return(Time.parse("June 9 2014"))
    Time.stub(:now).and_return(Time.parse("June 10 2014"))
    task3 = TM::Task.new(project_id, "Task 3", 3)
    task3_id = task3.id

    TM::Task.mark_complete(task1_id)
    TM::Task.mark_complete(task2_id)
    TM::Task.mark_complete(task3_id)

    task1.complete = true
    task2.complete = true
    task3.complete = true

    array = [task3, task2, task1]

    expect(project.get_complete_tasks).to eq(array)
  end

  it "can retrieve a list of all incomplete tasks, sorted by priority and then creation date" do
    project = TM::Project.new("Test")
    project_id = project.id

    # expect(Time).to receive(:now).and_return(Time.parse("June 7 2014"))
    Time.stub(:now).and_return(Time.parse("June 7 2014"))
    task1 = TM::Task.new(project_id, "Task 1", 3)
    task1_id = task1.id

    # expect(Time).to receive(:now).and_return(Time.parse("June 8 2014"))
    Time.stub(:now).and_return(Time.parse("June 8 2014"))
    task2 = TM::Task.new(project_id, "Task 2", 1)
    task2_id = task2.id

    # expect(Time).to receive(:now).and_return(Time.parse("June 11 2014"))
    Time.stub(:now).and_return(Time.parse("June 9 2014"))
    task4 = TM::Task.new(project_id, "Task 4", 2)
    task4_id = task4.id

    # expect(Time).to receive(:now).and_return(Time.parse("June 9 2014"))
    Time.stub(:now).and_return(Time.parse("June 10 2014"))
    task3 = TM::Task.new(project_id, "Task 3", 3)
    task3_id = task3.id


    array = [task2, task4, task3, task1]

    expect(project.get_incomplete_tasks).to eq(array)


  end

end
