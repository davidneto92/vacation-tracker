class UserVisitsSerializer
  include ActiveModel::Serialization

  def self.perform(user)
    visited_parks = user.parks.uniq

    list = []
    Park.all.each_with_index do |park, index|
      list << park.as_json
      list[index]["full_name"] = park.full_name
      list[index]["park_id"] = park.id
      if visited_parks.include?(park)
        list[index]["visited"] = true
        list[index]["most_recent_vacation_name"] = park.visits.where(user_id: user.id).order(:end_date).last.vacation.name
        list[index]["most_recent_visit_date"] = park.visits.where(user_id: user.id).order(:end_date).last.end_date.strftime "%B %e, %Y"
      else
        list[index]["visited"] = false
      end
    end

    return list
  end

end
