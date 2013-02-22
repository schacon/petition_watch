require 'digest/md5'

module ApplicationHelper
  def gravatar
    email = @current_user.email.downcase
    hash = Digest::MD5.hexdigest(email)
    image_src = "http://www.gravatar.com/avatar/#{hash}"
  end
end
