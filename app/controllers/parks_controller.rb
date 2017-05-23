class ParksController < ApplicationController
  def show
    @park = Park.where(id: params[:id])[0]
  end

  def index
    @parks = Park.all
  end
end
