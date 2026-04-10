class UsersController < ApplicationController
    allow_unauthenticated_access only: %i[new create]

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
        @users =
        if @query.present?
            User.where(
            "first_name ILIKE :q OR last_name ILIKE :q OR email_address ILIKE :q",
            q: "%#{@query}%"
            ).order(:last_name, :first_name)
        else
            User.order(:last_name, :first_name)
        end
    end

    def show
        @user = User.includes(:properties, :documents).find(params[:id])
    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :phone, :address, :photo, :password, :password_confirmation, :email_address)
    end

end
