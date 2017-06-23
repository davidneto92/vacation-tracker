class ParksController < ApplicationController
  def show
    @park = Park.where(id: params[:id])[0]
    if @park.drivable == true
      @drivable = "Yes"
    else
      @drivable = "No"
    end
    @vacations = @park.vacations.where(display_public: true)
    @visit_count = @park.visits.length
  end

  def index
    @parks = Park.all
  end
end
