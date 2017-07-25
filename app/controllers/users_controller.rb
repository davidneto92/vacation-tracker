class UsersController < ApplicationController
  before_action :authorize_sign_in
  before_action :authorize_edit, only: [:edit, :update, :destroy]
  before_action :authorize_map_download, only: [:user_visits_download]

  CURRENT_DATE = Time.now.strftime("%d%m%Y")

  def omniauth_failure
    flash[:alert] = "There an error signing in with Google. Please try again."
    redirect_to root_path
  end

  def show
    @user = User.find(params[:id])

    if current_user == @user
      @vacations = @user.vacations
      @private_table = true
    else
      @vacations = @user.vacations.where(display_public: true)
    end

    if !@user.vacations.empty?
      @download_path = "https://s3.amazonaws.com/vacation-tracker/Visited_Parks_#{CURRENT_DATE}_#{@user.uid}.kml"
    else
      @download_path = "https://s3.amazonaws.com/vacation-tracker/blank_map_all_visits.kml"
    end

  end

  def edit
    @user = User.find(params[:id])
  end

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
      if @user.parks.empty?
        @download_path = "https://s3.amazonaws.com/vacation-tracker/blank_map_all_visits.kml"
      else
        map_data = UserVisitsSerializer.perform(@user)
        print_data = KmlWriter.write_kml(map_data, @user.uid)
        # binding.pry
        MapUploader.perform(print_data)
        @download_path = "https://s3.amazonaws.com/vacation-tracker/Visited_Parks_#{CURRENT_DATE}_#{@user.uid}.kml"
      end
    end
    render "map_download"
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

  def authorize_map_download
    if current_user.id != params[:user_id].to_i
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

end
