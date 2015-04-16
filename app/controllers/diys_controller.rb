class DiysController < ApplicationController
  def new
  	@diy=Diy.new
  end
end
