module ApplicationHelper
  def cp(path)
    "current-link" if current_page?(path)
  end

  def date_class(date)
    if date == "" or date.nil?
      "no_date"
    elsif Date.parse(convert_date(date)) == Date.today
      "due_today"
    elsif Date.parse(convert_date(date)) < Date.today
      "overdue"
    else
      "due_later"
    end
  end

  def convert_date(date)
    parts = date.split('/')
    "#{parts[2]}-#{parts[0]}-#{parts[1]}"
  end

end
