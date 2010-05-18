class AdminController < ApplicationController


  def index
	#@users = User.find(params[:id])

  end
  
  
  def show_users
	@users = User.find(:all, :order => :name)

    respond_to do |format|
	format.html # index.html.erb
	format.xml  { render :xml => @users }
    end
  end
  
end
