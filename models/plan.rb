class Plan < ActiveRecord::Base
  belongs_to :owner_user, :class_name => "Account"
  has_many :account_plans, :dependent => :destroy
  has_many :accounts, through: :account_plans

  def owner?(user)
    self.owner_user.id == user.id
  end
end
