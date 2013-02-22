module ApplicationHelper
  def gravatar
    @current_user.email
  end
end
