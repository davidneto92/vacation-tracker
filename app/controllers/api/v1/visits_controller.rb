class Api::V1::VisitsController < ApplicationController
  def index
    list = Visit.all.map { |visit|
      {
        id: visit.id,
        vacation_id: visit.vacation_id,
        park_name: visit.park.full_name,
        visit_date: visit.text_dates,
        lat: visit.park.latitude,
        lng: visit.park.longitude
        }
      }

    render json: list
  end
end
