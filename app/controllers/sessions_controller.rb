class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      # Save the user id inside the browser cookie, logging the user in
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in successfully."
    else
      # If login fails, render the login form again
      flash[:alert] = "Invalid email or password."
      redirect_to new_session_path
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to new_session_path
  end

end