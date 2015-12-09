class UsersController < ApplicationController
  before_action :authenticate, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
    #segment track a user who visited to register a new user form
    segment_track_visit_register_new_user()
  end

  def create
    @user = User.new(user_params)
    if @user.save

      #segment track register user
      segment_track_success_register_user(@user)

      redirect_to articles_path, notice: 'User successfully added.'
    else
      #segment track fail register user
      error = ""
      @user.errors.full_messages.each do |msg|
        error << " - #{msg}"
      end

      email = user_params[:email].nil? ? '' : user_params[:email]
      segment_track_fail_register_user(email, error)

      render action: :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to articles_path, notice: 'Updated user information successfully.'
    else
      render action: 'edit'
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
