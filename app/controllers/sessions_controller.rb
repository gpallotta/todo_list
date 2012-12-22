class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to tasks_path
    else
      flash.now[:error] = "Incorrect username/password combination"
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to tasks_url
  end

end
