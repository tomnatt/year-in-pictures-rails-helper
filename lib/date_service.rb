class DateService
  def self.define_last_month
    # Return this month if we're past 20th of the month
    return Date.current.month if Date.current.day > 20
    # Months run 1..12 - return Dec if we're in Jan
    Date.current.month > 1 ? Date.current.month - 1 : 12
  end
end
