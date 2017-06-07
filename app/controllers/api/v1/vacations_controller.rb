class Api::V1::VacationsController < ApplicationController

  # can be revised to supply a map of all parks and basic stats
  def index
    # list = Visit.all.map { |visit|
    #   {
    #     id: visit.id,
    #     user_id: visit.user_id,
    #     vacation_id: visit.vacation_id,
    #     name: visit.park.name,
    #     full_name: visit.park.full_name,
    #     visit_date: visit.text_dates,
    #     lat: visit.park.latitude,
    #     lng: visit.park.longitude
    #     }
    #   }
    #
    # render json: list
  end

  def show
    @vacation = Vacation.find(params[:id])

    list = @vacation.visits.map { |visit|
      {
        id: visit.id,
        user_id: visit.user_id,
        vacation_id: visit.vacation_id,
        name: visit.park.name,
        full_name: visit.park.full_name,
        visit_date: visit.text_dates,
        lat: visit.park.latitude,
        lng: visit.park.longitude
        }
      }

    render json: list
  end

end
