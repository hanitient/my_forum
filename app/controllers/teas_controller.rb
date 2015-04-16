class TeasController < ApplicationController

  def new
  	@tea=Tea.new
  end

  def create
  	@tea = Tea.new(tea_params)
  	if @tea.save
      redirect_to @tea
    else
      render 'new'
    end
  end

  def show
  @tea=Tea.find(params[:id])
  end

  def index
  	@teas=Tea.where(:kind => '茶').paginate(page: params[:page], :per_page => 3 )
  end

  def index2
  	@teas=Tea.where(:kind => '果汁').paginate(page: params[:page], :per_page => 3 )
  end

  def index3
  	@teas=Tea.where(:kind => '保健饮品').paginate(page: params[:page], :per_page => 3 )
  end
#删除
  def destroy
    Tea.find(params[:id]).destroy
    flash[:success] = "用户已删除！"
    redirect_to users_url
  end

  private 
   def tea_params
    params.require(:tea).permit(:name, :kind, :describe)
   end
  	

end
