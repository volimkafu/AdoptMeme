class SessionsController < ApplicationController
	def new
    render :new
	end

	def create
    @user = User.find_by_credentials(params[:user])
    if !!@user
      login(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["No user was found with those credentials."]
      render :new
    end
  end

  def destroy
    logout(self.current_user)
    flash.now[:notices] = ['Goodbye, #{self.current_user.username}. Come again soon!']
    redirect_to new_session_url
  end

end
