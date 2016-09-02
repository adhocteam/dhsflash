module ApplicationHelper
  def avatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.try(:email).try(:downcase) || '')
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=150&d=mm"
  end
end
