class UsersController < ApplicationController
  # GET /users
  # GET /users.xml

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
    render "login"
  end

  def index
	@user = User.find(session[:user_id])
	#render 'show'
=begin
    @users = User.find(:all, :order => :name)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
=end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
	
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = "User \'#{@user.name}\' successfully created."
        format.html { redirect_to(:action => 'index') }#{ redirect_to(@user) } 
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

    
  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = "User \'#{@user.name}\' successfully updated."
        format.html { redirect_to(:controller => 'admin', :action => 'index') } #{ redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "User \'#{@user.name}\' is now deleted."

    respond_to do |format|
      format.html { redirect_to(:controller => 'admin', :action => 'index') }
      format.xml  { head :ok }
    end
  end
end
