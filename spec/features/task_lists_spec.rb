require 'rails_helper'
require 'capybara/rails'

feature 'Task lists' do

  scenario 'User can view task lists' do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")
    TaskList.create!(name: "Household Chores")

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    expect(page).to have_content("Work List")
    expect(page).to have_content("Household Chores")
  end

  scenario 'User can add a new task' do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")
    TaskList.create!(name: "Household Chores")

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    first(:link, '+ Add Task').click
    expect(page).to have_content "Add a task"
    fill_in "task[name]", with: "New Task"
    select "2015", from: "task[due_date(1i)]"
    select "06", from: "task[due_date(2i)]"
    select "06", from: "task[due_date(3i)]"

    click_on "Create Task"
    expect(page).to have_content "New Task"
  end

  scenario 'User can complete a task and remove it from the list' do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")
    TaskList.create!(name: "Household Chores")

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    first(:link, '+ Add Task').click
    expect(page).to have_content "Add a task"
    fill_in "task[name]", with: "New Task"
    select "2015", from: "task[due_date(1i)]"
    select "06", from: "task[due_date(2i)]"
    select "06", from: "task[due_date(3i)]"

    click_on "Create Task"
    click_on "Complete Task"

    expect(page).to_not have_content "New Task"
  end

  scenario 'User should see message when there are no tasks for a task list' do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")
    TaskList.create!(name: "Household Chores")

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    expect(page).to have_content "Nothing here to see!"
  end

end