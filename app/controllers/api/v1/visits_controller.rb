class Api::V1::VisitsController < ApplicationController
  def index
    list = Visit.all.map { |visit|
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
