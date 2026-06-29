class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]

  def new
    @user = User.new
  end

  def create
    @params = params.expect user: [ :email_address, :password, :password_confirmation ]
    @user = User.new @params

    begin
      @user.save
      flash[:notice] = "User created"
    rescue ActiveRecord::RecordNotUnique
      flash[:alert] = "User already exists"
    ensure
      Current.session&.delete(:return_to_after_authenticating)
      redirect_to new_session_path
    end
  end
end
