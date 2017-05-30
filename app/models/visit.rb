class Visit < ApplicationRecord
  belongs_to :user
  belongs_to :vacation
  belongs_to :park

  validate :start_date_okay
  validate :end_date_okay

  def start_date_okay
    if self.start_date < self.vacation.start_date || self.start_date > self.vacation.end_date
      errors.add("Start date", "cannot conflict with the vacation dates.")
    end

    if self.start_date > self.end_date
      errors.add("Start date", "must be before or the same as the visit end date.")
    end
  end

  def end_date_okay
    if self.end_date < self.vacation.start_date || self.end_date > self.vacation.end_date
      errors.add("End date", "cannot conflict with the vacation dates.")
    end

    if self.end_date < self.start_date
      errors.add("End date", "must be after or the same as the visit start date.")
    end
  end

  def text_dates
    if (self.start_date.year != self.end_date.year)
      # years different
      return "#{self.start_date.strftime "%B %e, %Y"} - #{self.end_date.strftime "%B %e, %Y"}"
    elsif self.start_date.month != self.end_date.month
      # years same, months different
      return "#{self.start_date.strftime "%B %e"} - #{self.end_date.strftime "%B %e"}"
    else
      #years same, months same
      return "#{self.start_date.strftime "%B %e"} - #{self.end_date.strftime "%e"}"
    end
  end

end
