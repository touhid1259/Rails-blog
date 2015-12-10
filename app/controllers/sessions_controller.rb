class SessionsController < ApplicationController
  # get login form
  def index
    if logged_in
      redirect_to articles_path
    end
    @user = User.new
  end

  # login user with credentials
  def login
    @user = User.find_by(name: params[:session][:name].downcase)

    if @user && @user.authenticate(params[:session][:password]) && @user.is_confirmed
      #Log the user in and regirect to the article page
      log_in @user
      redirect_to articles_path

    elsif @user && @user.authenticate(params[:session][:password]) && !@user.is_confirmed
      flash.now[:notice] = 'Please confirm your Account'
      render 'index'

    else
    #show error message that user is invalid
      flash.now[:error] = 'Invalid username/password'
      render 'index'
    end
  end

  # logout
  def logout
    log_out
    redirect_to login_path
  end

  # get signup form
  def sign_up
    if logged_in
      redirect_to articles_path
    end
  end

  # signup user
  def complete_signup
    user = User.new({first_name: params[:session][:first_name], last_name: params[:session][:last_name],
                     email_address: params[:session][:email].downcase, name: params[:session][:user_name].downcase,
                     password_digest: params[:session][:password], confirm_password: params[:session][:confirm_password] })

    # For confirmation link
    user.confirmation_token = SecureRandom.uuid

    if user.save
      NotificationsMailer.confirmation_mailer(user).deliver_now

      respond_to do |format|
        format.html {}
      end

    else
      @errors = user.errors.messages
      render 'sign_up'

    end
  end

  def confirm_account
    user = User.find_by_confirmation_token(params[:token])
    if(user && !user.is_confirmed)
      user.update_attribute(:is_confirmed, true)
      log_in user
      flash[:notice] = 'Account confirmed and logged in.'
      redirect_to new_profile_path

    elsif(user && user.is_confirmed)
      log_in user
      flash[:notice] = 'You have already confirmed your account'
      redirect_to articles_path

    else
      flash[:notice] = 'Invalid Request'
      redirect_to root_path

    end
  end

end
