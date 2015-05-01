module ApplicationHelper

  def action?(controller, action)
    controller == params[:controller] && params[:action] == action
  end
end
