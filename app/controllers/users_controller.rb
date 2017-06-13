class UsersController < ApplicationController
  before_action :authorize_sign_in
  before_action :authorize_edit, only: [:edit, :update, :destroy]
  before_action :authorize_map_download, only: [:user_visits_download]

  def omniauth_failure
    flash[:alert] = "There an error signing in with Google. Please try again."
    redirect_to root_path
  end

  def show
    @user = User.find(params[:id])
    if !@user.vacations.empty?
      @vacations = @user.vacations.where(display_public: true)
    end
    time = Time.now.strftime("%d%m%Y")
    @download_path = "https://s3.amazonaws.com/vacation-tracker/Visited_Parks_#{time}_#{@user.uid}.kml"
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
      path = KmlWriter.write_kml(map_data, @user.uid)

      # wasn't sure of best way to get this method to load with my application
      s3 = Aws::S3::Resource.new(region:'us-east-1')
      obj = s3.bucket(ENV['AWS_BUCKET']).object(path[1])
      obj.upload_file(path[0])

      @download_path = "https://s3.amazonaws.com/vacation-tracker/#{path[1]}"
      render "map_download"
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

  def authorize_map_download
    if current_user.id != params[:user_id].to_i
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

end
