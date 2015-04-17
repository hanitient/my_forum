class DiysController < ApplicationController

  def new
  	@diy=Diy.new
  end

  def create 
  	#建立一个和user_id相关联的diy
  	@diy = current_user.diys.build(diy_params)
  	if @diy.save
      redirect_to @diy
    else
      render 'new'
    end
  end

  def show
  	 @diy=Diy.find(params[:id])

  end

  def index
  	@diys=Diy.where(:user_id => current_user.id).paginate(page: params[:page], :per_page => 3)
  end

  private 
   def diy_params
    params.require(:diy).permit(:name,:describe,:user_id)
   end

end
