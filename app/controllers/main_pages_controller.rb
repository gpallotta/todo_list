class MainPagesController < ApplicationController
  def home
    if signed_in?
      @task = current_user.tasks.build if signed_in?
      @feed_items = current_user.feed
    end
  end

  def help
  end

end
