class AdminController < ApplicationController

  # just display the form and wait for user to
  # enter a name and password
   before_filter :authorize, :except => :login
  
  def login
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user &&  user.id == 1
        session[:user_id] = user.id
        redirect_to(:action => "index")
      elsif user
	session[:user_id] = user.id
        redirect_to(:controller => "limited", :action => "index")
      else
        flash.now[:notice] = "Invalid user/password combination!"
      end
    end
  end
  

  def logout
    session[:user_id] = nil
    flash[:notice] = 'Logged out'
    redirect_to(:action => "login")
  end

  
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