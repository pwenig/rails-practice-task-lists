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
    expect(page).to have_content("+ New Task")
  end

  scenario 'User can add a task' do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")
    TaskList.create!(name: "Household Chores")

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    first(:link, "+ New Task").click
    fill_in "task[description]", with: "A fun task"
    select "2015", from: "task[due_date(1i)]"
    select "06", from: "task[due_date(2i)]"
    select "06", from: "task[due_date(3i)]"
    click_on "Create Task"
    expect(page).to have_content "Task was created successfully!"
    expect(page).to have_content "A fun task"
    expect(page).to have_content "11 months"
  end

  scenario 'User cannot add a task without a description' do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")
    TaskList.create!(name: "Household Chores")

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    first(:link, "+ New Task").click
    fill_in "task[description]", with: ""
    select "2015", from: "task[due_date(1i)]"
    select "06", from: "task[due_date(2i)]"
    select "06", from: "task[due_date(3i)]"
    click_on "Create Task"
    expect(page).to have_content "Your task could not be created"
  end

  scenario 'User can complete a task and have it removed from the display' do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")
    TaskList.create!(name: "Household Chores")

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    first(:link, "+ New Task").click
    fill_in "task[description]", with: "A fun task"
    select "2015", from: "task[due_date(1i)]"
    select "06", from: "task[due_date(2i)]"
    select "06", from: "task[due_date(3i)]"
    click_on "Create Task"
    click_on "Complete Task"
    expect(page).to_not have_content "A fun task"
  end

  scenario 'User sees a message when there are no tasks' do
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

  scenario 'User can only see their own tasks' do
    create_user name: "user1", email: "user1@example.com", password: "password1", password_confirmation: "password1"
    create_user name: "user2", email: "user2@example.com", password: "password2", password_confirmation: "password2"
    TaskList.create!(name: "Work List")
    TaskList.create!(name: "Household Chores")

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user1@example.com"
    fill_in "Password", with: "password1"
    click_on "Login"
    first(:link, "+ New Task").click
    fill_in "task[description]", with: "A fun task"
    select "2015", from: "task[due_date(1i)]"
    select "06", from: "task[due_date(2i)]"
    select "06", from: "task[due_date(3i)]"
    click_on "Create Task"
    click_on "Logout"

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user2@example.com"
    fill_in "Password", with: "password2"
    click_on "Login"

    expect(page).to_not have_content "A fun task"
  end
end