module UsersHelper
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar", title: user.name)
  end
  
  def retweet_user(micropost)
    post = Micropost.find_by(id: micropost.retweet)
    post.user
  end
  
  def retweet_post(micropost)
     Micropost.find_by(id:micropost.retweet)
  end
end