class TestFormController < ApplicationController
  def index
  end

  def create
  	render plain: params[:test_form]
  end

end