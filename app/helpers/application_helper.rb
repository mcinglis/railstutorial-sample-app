module ApplicationHelper

  def full_title(page_title = '')
    base_title = 'Sample App'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def digest_password(password)
    BCrypt::Password.create(password)
  end

end
