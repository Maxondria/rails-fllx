module UsersHelper
  def profile_image(user)
    image_tag("http://secure.gravatar.com/avatar/#{user.gravatar_id}", alt: user.name)
  end
end
