module ApplicationHelper
  def active_filter_class(category)
    params[:category] == category ? "active" : ""
  end

end
