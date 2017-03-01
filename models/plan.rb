class Plan < ActiveRecord::Base
  belongs_to :owner_user, class_name: 'Account'
  has_many :account_plans, dependent: :destroy
  has_many :attend_accounts, through: :account_plans, source: :account

  def owner?(user)
    owner_user.id == user.id
  end
end
