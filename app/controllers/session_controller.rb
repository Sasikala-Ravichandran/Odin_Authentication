class SessionController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      if params[:session][:remember_me] == 1 ? remember(user) : forget(user)
        redirect_to user
      else
        flash.now[:danger] = 'Invalid user'
        render 'new'
      end
    end

    def delete
      log_out
      render 'new'
    end
end