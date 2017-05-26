class VisitsController < ApplicationController
  before_action :authorize_sign_in
  before_action :authorize_creation, only: [:new]
  before_action :authorize_management, only: [:edit, :update, :destroy]

  def new
    @vacation = Vacation.find(params[:vacation_id])
    @park_list = Park.all.order(:name)
    @visit = Visit.new
  end

  def create
    @visit = Visit.new(visit_params)
    @visit.user = current_user
    @visit.vacation = Vacation.find(params[:vacation_id])
    @visit.park = Park.find(params[:park_id])

    if @visit.save
      flash[:notice] = "Visit added to #{@visit.vacation.name}."
      redirect_to vacation_path(@visit.vacation)
    else
      flash[:alert] = "Visit was not added."
      @vacation = Vacation.find(params[:vacation_id])
      @park_list = Park.all.order(:name)
      render :new
    end
  end

  def edit
    # binding.pry
    @vacation = Vacation.find(params[:vacation_id])
    @park_list = Park.all.order(:name)
    @visit = Visit.find(params[:id])
  end

  def update
    @visit = Visit.find(params[:id])
    @visit.update(visit_params)
    @visit.park = Park.find(params[:park_id])
    @vacation = Vacation.find(params[:vacation_id])

    if @visit.save
      flash[:notice] = "Visit updated!"
      redirect_to vacation_path(@visit.vacation)
    else
      flash[:alert] = "Visit was not updated."
      @park_list = Park.all.order(:name)
      render :new
    end
  end


  private

  def visit_params
    params.require(:visit).permit(:start_date, :end_date)
  end

  def authorize_sign_in
    if current_user.nil?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

  def authorize_creation
    # binding.pry
    if !(current_user.vacations.include?(Vacation.find(params[:vacation_id])))
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

  def authorize_management
    if !(current_user.vacations.include?(Vacation.find(params[:id])))
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

end
