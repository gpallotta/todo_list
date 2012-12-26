class TasksController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy

  def index
    if signed_in?
      @task = current_user.tasks.build if signed_in?
      @tasks = current_user.tasks.where("user_id = ?", current_user.id)
    end

    respond_to do |format|
      format.html
    end
  end

  def create
    @task = current_user.tasks.build(params[:task])
    respond_to do |format|
      if @task.save
        format.js { render :layout => false }
        format.html {
          flash[:success] = "Task created!"
          redirect_to tasks_path
        }
      else
        format.html {
          @feed_items = []
          render 'main_pages/home'
        }
      end
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    current_user.update_column(:number_done, current_user.number_done+1)
    respond_to do |format|
      format.js { render :layout => false }
      format.html { redirect_to(tasks_path) }
    end
  end

  private

  def correct_user
    @task = current_user.tasks.find_by_id(params[:id])
    redirect_to root_url if @task.nil?
  end

end
