class Api::V1::UserVisitsController < ApplicationController

  def show
    user = User.find(params[:id])
    # only lists parks that were visited in a publicly listed vacation
    visited_parks = user.visits.map { |visit| visit.park if (visit.vacation.display_public == true) }.uniq

    list = []
    Park.all.each_with_index do |park, index|
      list << park.as_json
      list[index][:full_name] = park.full_name
      list[index][:park_id] = park.id
      if visited_parks.include?(park)
        list[index][:visited] = true
        list[index][:most_recent_vacation_id] = park.visits.where(user_id: user.id).order(:end_date).last.vacation_id
        list[index][:most_recent_vacation_name] = park.visits.where(user_id: user.id).order(:end_date).last.vacation.name
      else
        list[index][:visited] = false
      end
    end

    render json: list
  end

end
