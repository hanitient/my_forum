module SessionsHelper

  #登录用户的方法定义
  def log_in(user)
    session[:user_id] = user.id
  end

  
  #获得当前用户
  def current_user
    if (user_id = session[:user_id])
    @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
    user = User.find_by(id: user_id)
    if user && user.authenticated?(:remember, cookies[:remember_token])
    log_in user
    @current_user = user
    end
   end
  end

   

    #如果用户已经登录返回true，反之false
  def logged_in?
    !current_user.nil?
  end
    #登出
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  #如果用户是指定用户返回true
  def current_user?(user)
    user == current_user
  end

  #重定向到用户登录前的页面
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  #储存需要重定向的地址
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  #在持久会话中记住用户
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
end
