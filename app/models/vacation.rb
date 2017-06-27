class Vacation < ApplicationRecord
  belongs_to :user

  has_many :visits, dependent: :destroy
  has_many :parks, through: :visits

  validates :name, :location, :start_date, :end_date, presence: true
  validates :name, length: { minimum: 5 }
  validates :display_public, inclusion: { in: [true, false], message: "- please select if this vacation should be publicly viewable" }
  validates :description, length: { minimum: 20 }, allow_blank: true
  validate :vacation_has_happened
  validate :dates_acceptable

  def vacation_has_happened
    if (self.start_date) > Date.today
      errors.add("Start date", "cannot be in the future.")
    end
    if (self.end_date) > Date.today
      errors.add("End date", "cannot be in the future.")
    end
  end

  def dates_acceptable
    if (self.start_date > self.end_date)
      errors.add("End date", "must be after the start date.")
    end
  end

  def text_dates
    return "#{self.start_date.strftime "%B %e, %Y"} - #{self.end_date.strftime "%B %e, %Y"}"
  end

  def find_center
    lat_average = (self.visits.map{ |visit| visit.park.latitude }.inject(:+))  / self.visits.count
    lng_average = (self.visits.map{ |visit| visit.park.longitude }.inject(:+)) / self.visits.count
    return [lat_average.round(3), lng_average.round(3)]
  end

  def find_zoom

  end

end
