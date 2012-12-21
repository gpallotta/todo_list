class MainPagesController < ApplicationController
  def home
    if signed_in?
      @task = current_user.tasks.build if signed_in?
      @tasks = current_user.feed
    end
  end

  def help
  end

end
