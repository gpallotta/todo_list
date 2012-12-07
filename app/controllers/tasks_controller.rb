class TasksController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy

  def create
    @task = current_user.tasks.build(params[:task])
    if @task.save
      flash[:success] = "Task created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'main_pages/home'
    end
  end

  def destroy
    @task.destroy
    redirect_to root_path
  end

  def toggle_done
    @task = Task.find(params[:id])
    @task.done = true
    @task.save
    redirect_to root_path
  end

  private

  def correct_user
    @task = current_user.tasks.find_by_id(params[:id])
    redirect_to root_url if @task.nil?
  end
end
