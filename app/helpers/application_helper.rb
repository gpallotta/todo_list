module ApplicationHelper
  def cp(path)
    "current-link" if current_page?(path)
  end
end
