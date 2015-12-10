class WelcomeController < ApplicationController
  def index
  end
  
  def about_us
  	@names = ["Albi","Alex","Omer","Waqar","Touhid"]
  end

end
