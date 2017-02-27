class Account < ActiveRecord::Base
  def self.create_with_omniauth(auth)
    create! do |account|
      account.name        = auth["info"]["name"]
      account.screen_name = auth["info"]["nickname"]
      account.icon_url    = auth["info"]["image"]

      account.role        = "users"

      account.provider    = auth["provider"]
      account.uid         = auth["uid"]

      account.access_token = auth["credentials"]["token"]
      account.access_token_secret = auth["credentials"]["secret"]

      account.living_latitude = 35.689634
      account.living_longitude = 139.692101
    end
  end
end
