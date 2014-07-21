class TasksController < ApplicationController

  def new
    @task_list = TaskList.find(params[:task_list_id])
    @task = Task.new
  end

  def create
    @task_list = TaskList.find(params[:task_list_id])
    @task = Task.new(task_attributes)
    @task.user_id = session[:user_id]
    if @task.save
      flash.notice = "Task was created successfully!"
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    task = Task.find(params[:id])
    task.update(completed: true)
    redirect_to root_path
  end


  private
  def task_attributes
    params.require(:task).permit(:description, :due_date).merge(task_list_id: params[:task_list_id])
  end

end