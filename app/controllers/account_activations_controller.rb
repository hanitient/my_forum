class AccountActivationsController < ApplicationController

	def edit
user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
user.activate
log_in user
flash[:success] = "账户激活成功！"
redirect_to user
    else
flash[:danger] = "无效的激活地址"
redirect_to root_url
    end
  end

end
