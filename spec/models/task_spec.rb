require 'rails_helper'

describe Task do

  it "tests validations" do
    task = Task.new(description: "A fun task", due_date: "2014-09-09", task_list_id: 1)
    expect(task.valid?).to eq true
  end

  it "tests validations" do
    task = Task.new(description: "", due_date: "2014-09-09", task_list_id: 1)
    expect(task.valid?).to eq false
  end
end