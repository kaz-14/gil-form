class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @tasks = current_user.tasks
  end
  
  def show
    @task = target_task params[:id]
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path
    else
      render 'new'
    end
  end
  
  def edit
    @task = target_task params[:id]
  end
  
  def update
    @task = target_task params[:id]
    @task.update(task_params)
    redirect_to tasks_path
  end
  
  def destroy
    @task = target_task params[:id]
    @task.destroy
    redirect_to tasks_path
  end
  
  private
  def target_task task_id
    current_user.tasks.where(id: task_id).take
  end
  
  def task_params
    params.require(:task).permit(:title, :description, :state).merge(user_id: current_user.id)
  end
end
