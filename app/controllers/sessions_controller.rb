class SessionsController < ApplicationController

  def new
  end

  def create 
  	user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
       if user.activated?
       log_in user
       params[:session][:remember_me] == '1' ? remember(user) : forget(user)
       redirect_back_or user
       else
       message = "账户未激活. "
       message += "查看你的邮箱."
       flash.now[:warning] = message
        render 'new'
      end

    else
      flash.now[:danger] = '用户名或密码不正确'
      render 'new'
     end
  end

  def destroy
  	log_out
    redirect_to root_url
  end



end
