class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[new create]
  before_action :require_admin!, only: %i[toggle_verification]
  before_action :set_user, only: %i[show toggle_verification]
  before_action :require_visible_user!, only: %i[show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      start_new_session_for @user
      redirect_to root_path, notice: "Account created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
  @query = params[:q].to_s.strip

  base_scope =
    if Current.user&.admin?
      User.all
    else
      User.where(is_verified: true)
    end

  @users =
    if @query.present?
      base_scope.where(
        "first_name ILIKE :q OR last_name ILIKE :q OR email_address ILIKE :q",
        q: "%#{@query}%"
      ).order(:last_name, :first_name)
    else
      base_scope.order(:last_name, :first_name)
    end
  end

  def show
  end

  def toggle_verification
    if @user == Current.user
        redirect_to users_path, alert: "You cannot change your own verification status."
        return
    end

    @user.update!(is_verified: !@user.is_verified)
    redirect_to users_path, notice: verification_message(@user)
  end

  private

  def require_visible_user!
    return if Current.user&.admin?
    return if @user.is_verified?

    redirect_to users_path, alert: "Not authorized."
  end

  def set_user
    @user = User.includes(:properties, :documents).find(params[:id])
  end

  def require_admin!
    redirect_to root_path, alert: "Not authorized." unless Current.user&.admin?
  end

  def verification_message(user)
    if user.is_verified?
      "#{user.first_name} #{user.last_name} is now verified."
    else
      "#{user.first_name} #{user.last_name} is now unverified."
    end
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :phone,
      :address,
      :photo,
      :password,
      :password_confirmation,
      :email_address
    )
  end
end