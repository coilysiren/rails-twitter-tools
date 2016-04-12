class Action < ActiveRecord::Base

  attr_encrypted :user_key, :key => Rails.application.secrets.secret_key_base
  attr_encrypted :user_secret, :key => Rails.application.secrets.secret_key_base

  validates :user_id, presence: true
  validates :user_key, presence: true
  validates :user_secret, presence: true
  validates :target_id, presence: true
  validates :unmute_when, presence: true

end
