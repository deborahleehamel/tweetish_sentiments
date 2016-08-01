class User < ApplicationRecord

  def self.from_omniauth(auth_info)
    where(uid: auth_info[:uid]).first_or_create do |new_user|
      new_user.uid                = auth_info.uid
      new_user.screen_name        = auth_info.extra.raw_info.screen_name
      new_user.token              = auth_info.credentials.token
      new_user.secret             = auth_info.credentials.secret
      new_user.provider           = auth_info.provider
      new_user.profile_image      = auth_info.info.image
    end
  end

end
