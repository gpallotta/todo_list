module ApplicationHelper
  def cp(path)
    "current-link" if current_page?(path)
  end

  def date_class(date)
    if date == ""
      "no_date"
    elsif Timeliness.parse(date) == Date.today
      "due_today"
    elsif Timeliness.parse(date) < Date.today
      "overdue"
    elsif Timeliness.parse(date)+3.days < Date.today
      "due_soon"
    else
      "due_later"
    end
  end

end
