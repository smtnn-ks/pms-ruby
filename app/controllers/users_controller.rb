class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]

  def new
    @user = User.new
  end

  def create
    @params = params.expect user: [ :email_address, :password, :password_confirmation ]
    @user = User.new @params

    begin
      if not @user.save
        render :new, status: :unprocessable_entity
      else
        Current.session&.delete(:return_to_after_authenticating)
        redirect_to new_session_path, notice: "User was successfully created."
      end
    rescue ActiveRecord::RecordNotUnique
      render :new, status: :unprocessable_entity, alert: "User already exists"
    ensure
    end
  end
end
