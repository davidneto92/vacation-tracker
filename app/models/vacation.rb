class Vacation < ApplicationRecord

  belongs_to :user

  validates :name, :location, :start_date, :end_date, presence: true
  validates :public, inclusion: { in: [true, false], message: "NOPE!" } 
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

end
