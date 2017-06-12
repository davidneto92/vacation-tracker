class UsersController < ApplicationController
  before_action :authorize_sign_in
  before_action :authorize_edit, only: [:edit, :update, :destroy, :user_visits_download]

  def omniauth_failure
    flash[:alert] = "There an error signing in with Google. Please try again."
    redirect_to root_path
  end

  def show
    @user = User.find(params[:id])
    if !@user.vacations.empty?
      @vacations = @user.vacations.where(display_public: true)
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  # def update
  # end

  def destroy
    @user = User.find(params[:id])
    session[:user_id] = nil
    @user.destroy
    redirect_to root_path
  end

  def user_visits_download
    if params[:user_id].nil?
      redirect_to root_path
    else
      @user = User.find(params[:user_id])
      map_data = UserVisitsSerializer.perform(@user)
      KmlWriter.write_kml(map_data)
    end
  end

  private

  def authorize_sign_in
    if current_user.nil?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

  def authorize_edit
    if current_user.id != params[:id].to_i
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

end
