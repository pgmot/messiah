class Account < ActiveRecord::Base
  has_many :account_plans
  has_many :attend_plans, :through => :account_plans, :source => :plan

  has_many :owner_plans, class_name: "Plan", :foreign_key => :owner_user_id

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

  def friend?(user)
    return false if user.nil?

    account_relation_count = AccountRelation.where("(uid = ? and follow_uid = ?) or (uid = ? and follow_uid = ?)", self.uid, user.uid, user.uid, self.uid).count

    # 相互フォローなら上記条件で2件回答があるはず
    account_relation_count == 2
  end

  def friends
    user_follow_ids = AccountRelation.where("uid = ?", self.uid).pluck(:follow_uid)
    each_follow_ids = AccountRelation.where(uid: user_follow_ids).where("follow_uid = ?", self.uid).pluck(:uid)
    Account.where(uid: each_follow_ids)
  end
end
