require 'rails_helper'
require 'capybara/rails'

feature 'Task lists' do

  scenario 'User can view their own task lists' do
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

    first(:link, '+ Add Task').click
    fill_in "task[name]", with: "Some Great New Task"
    select "2015", from: "task[due_date(1i)]"
    select "06", from: "task[due_date(2i)]"
    select "06", from: "task[due_date(3i)]"
    click_on "Create Task"

    click_on "Logout"

    create_user email: "user2@example.com", name: "Some New", password: "password1", password_confirmation: "password1"
    visit signin_path

    click_on "Login"
    fill_in "Email", with: "user2@example.com"
    fill_in "Password", with: "password1"
    click_on "Login"
    expect(page).to_not have_content "Some Great New Task"
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

  scenario 'Non-logged in user cannot visit new task path' do
   task_list =  TaskList.create!(name: "Work List")
    visit new_task_list_task_path(task_list)
    expect(page).to have_content "Email"
    expect(page).to have_content "Password"

  end
end