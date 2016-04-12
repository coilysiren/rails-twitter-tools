class User < ActiveRecord::Base

  attr_encrypted :user_key, :key => Rails.application.secrets.secret_key_base
  attr_encrypted :user_secret, :key => Rails.application.secrets.secret_key_base

  validates :user_id, presence: true
  validates :user_key, presence: true
  validates :user_secret, presence: true
  validates :user_name, presence: true
  validates :user_picture, presence: true

  def self.get(auth)
    user = User.find_or_create_by(user_id: auth.extra.raw_info.id)
    user.update_attributes(
      user_key: auth.credentials.token,
      user_secret: auth.credentials.secret,
      user_name: auth['info']['name'],
      user_picture: auth['info']['image'],
    )
    return user
  end

end
