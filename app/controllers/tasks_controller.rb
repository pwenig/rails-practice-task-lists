class TasksController < ApplicationController

  def new
    @task = Task.new
    @task_list = TaskList.find(params[:task_list_id])
  end

  def create
    @task_list = TaskList.find(params[:task_list_id])
    @task = Task.new(task_attributes)
    if @task.save
      flash.notice = "Task was created successfully!"
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def task_attributes
    params.require(:task).permit(:name, :due_date).merge(task_list_id: params[:task_list_id])
  end

end