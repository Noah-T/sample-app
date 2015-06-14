class SessionsController < ApplicationController
  def new
  end

  def create
  	#first find user with email
  	user = User.find_by(email: params[:session][:email].downcase)
    #if user is found, check password with bcrypt
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      #show their profile
      redirect_to user
    else
    	#flash.now will show a message and disappear on the next page. flash will only disappear after it persits for one redirect (render doesn't count as a redirect)
    	flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
		render 'new'
	end
  end


  def destroy
    log_out
    redirect_to root_url
    
  end
end
