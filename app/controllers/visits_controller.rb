class VisitsController < ApplicationController

  # def show
  # end

  def new
    @vacation = Vacation.find(params[:vacation_id])
    @park_list = Park.all.order(:name)
    @visit = Visit.new
    # binding.pry
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
      flash[:notice] = "Visit was not added."
      @vacation = Vacation.find(params[:vacation_id])
      @park_list = Park.all.order(:name)
      render :new
    end

  end

  private

  def visit_params
    params.require(:visit).permit(:start_date, :end_date)
  end

end
