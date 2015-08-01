
module UsersHelper

  def gravatar_for(user, options = { size: 80 })
    id = Digest::MD5::hexdigest(user.email.downcase)
    url = "https://secure.gravatar.com/avatar/#{id}?s=#{options[:size]}"
    return image_tag(url, alt: user.name, class: 'gravatar')
  end

end

