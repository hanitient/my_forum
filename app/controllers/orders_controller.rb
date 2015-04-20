class OrdersController < ApplicationController
    before_action :admin_user,only: :indexall

  def admin_user
   redirect_to(root_url) unless current_user.admin?
  end

  def new
    @order=Order.new
  end

  def create
  	#@order = current_user.orders.build(params[:order])
    #@tea2=Tea.find(params[:id])
    #@order=current_user.orders.build(name:@tea.name,kind:@tea.kind,price:@tea.price,address:current_user.address1,describe:@tea.describe,status:"bought")
    @order=current_user.orders.build(name:$t1.name,kind:$t1.kind,price:$t1.price,address:current_user.address1,describe:$t1.describe,status:"bought")
  	if @order.save
      #redirect_to @order
    else
      render 'new'
    end
  end

  def show
  	 @order=Order.find(params[:id])

  end

  def index
  	@orders=Order.where(:user_id => current_user.id).paginate(page: params[:page], :per_page => 3)
  end

  def indexall
  	@orders=Order.paginate(page: params[:page], :per_page => 3)
  end

  private 
   def order_params
    params.require(:order).permit(:name,:kind,:price,:address,:describe,:user_id)
   end

end

