class ParksController < ApplicationController
  def show
    @park = Park.where(id: params[:id])[0]
    if @park.drivable == true
      @drivable = "Yes"
    else
      @drivable = "No"
    end
  end

  def index
    @parks = Park.all
  end
end
