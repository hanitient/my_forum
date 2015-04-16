class UsersController < ApplicationController
  #登录后才能进行以下操作
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  #用户只能编辑自己的资料
  before_action :correct_user,only: [:edit, :update]
  #管理员才能进行的删除用户操作
  before_action :admin_user,only: :destroy

  #判断是否是管理员
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

 #看到所有用户
  def index
    @users = User.paginate(page: params[:page])
  end

  #注册动作
  def new
  	@user=User.new
  end

  #显示用户资料
  def show
  @user=User.find(params[:id])
  end

  #注册成功创建用户
  def create
   @user = User.new(user_params)

   #判断是否注册成功
   if @user.save
   	 @user.send_activation_email
     flash[:info] = "查看你的邮箱以激活账户."
     redirect_to root_url
   else
     render 'new'
   end
  end

  #编辑用户的动作
  def edit
    @user = User.find(params[:id])
  end

 #处理更新资料的动作
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "资料更新成功！"
      redirect_to @user
    else
      render 'edit'
    end
  end

  #删除用户
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "用户已删除！"
    redirect_to users_url
  end

   private
   #引入健壮参数以防止用户所有哈希数据都能被初始化修改
    def user_params
      params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
    end

  #确保用户已经登录
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "请登录."
      redirect_to login_url
    end
  end

 #验证是否是正确的用户
  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
  end

end
