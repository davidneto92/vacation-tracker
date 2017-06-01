class Vacation < ApplicationRecord
  belongs_to :user

  has_many :visits, dependent: :destroy
  has_many :parks, through: :visits

  validates :name, :location, :start_date, :end_date, presence: true
  validates :name, length: { minimum: 5 }
  validates :display_public, inclusion: { in: [true, false], message: "- please select if this vacation should be publicly viewable" }
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
    # if (self.start_date.year != self.end_date.year)
    #   # years different
      return "#{self.start_date.strftime "%B %e, %Y"} - #{self.end_date.strftime "%B %e, %Y"}"
    # elsif self.start_date.month != self.end_date.month
    #   # years same, months different
    #   return "#{self.start_date.strftime "%B %e"} - #{self.end_date.strftime "%B %e"}"
    # else
    #   #years same, months same
    #   return "#{self.start_date.strftime "%B %e"} - #{self.end_date.strftime "%e"}"
    # end
  end

end
