class Account < ActiveRecord::Base
  def self.create_with_omniauth(auth)
    create! do |account|
      account.name        = auth["info"]["name"]
      account.screen_name = auth["info"]["nickname"]
      account.icon_url    = auth["info"]["image"]

      account.role        = "users"

      account.provider    = auth["provider"]
      account.uid         = auth["uid"]
    end
  end
end

# :uid => "123456",
# :info => {
#   :nickname => "johnqpublic",
#   :name => "John Q Public",
#   :location => "Anytown, USA",
#   :image => "http://si0.twimg.com/sticky/default_profile_images/default_profile_2_normal.png",
#   :description => "a very normal guy.",
#   :urls => {
#     :Website => nil,
#     :Twitter => "https://twitter.com/johnqpublic"
#   }
# },
