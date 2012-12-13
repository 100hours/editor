module ApplicationHelper
  def title_or_default(title)
    return title unless title.blank?
    "<em>Untitled</em>"
  end
end
