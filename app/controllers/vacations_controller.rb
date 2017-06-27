class VacationsController < ApplicationController
  before_action :authorize_sign_in, except: [:show, :index]
  before_action :authorize_view_permission, only: [:show]
  before_action :authorize_management, only: [:edit, :update, :destroy]

  def index
    @vacations = Vacation.where(display_public: true)
  end

  def show
    @vacation = Vacation.where(id: params[:id]).first
    @visits = @vacation.visits
    if !@visits.empty?
      @map_center = @vacation.find_center
    end
    if current_user == @vacation.user
      @private_table = true
    end
  end

  def new
    @vacation = Vacation.new
    @public_choice = [true, false]
  end

  def create
    @vacation = Vacation.new(vacation_params)
    @vacation.user_id = current_user.id

    if @vacation.save
      flash[:notice] = "Vacation created!"
      redirect_to vacation_path(@vacation)
    else
      flash[:alert] = "Vacation not created"
      render :new
    end
  end

  def edit
    @vacation = Vacation.where(id: params[:id]).first
    @public_choice = [true, false]
  end

  def update
    @vacation = Vacation.find(params[:id])
    @vacation.update(vacation_params)
    @vacation.user_id = current_user.id

    if @vacation.save
      flash[:notice] = "Vacation has been updated."
      redirect_to vacation_path(@vacation)
    else
      flash[:alert] = "Update failed."
      render :edit
    end
  end

  def destroy
    @vacation = Vacation.find(params[:id])
    @vacation.destroy
    redirect_to vacations_path
  end


  private

  def vacation_params
    params.require(:vacation).permit(
      :name, :location, :description, :start_date, :end_date, :display_public
    )
  end

  def authorize_sign_in
    if current_user.nil?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

  def authorize_view_permission
    if !(current_user == Vacation.find(params[:id]).user) && (Vacation.find(params[:id]).display_public == false)
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

  def authorize_management
    if !(current_user && current_user.vacations.include?(Vacation.find(params[:id])))
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

end
