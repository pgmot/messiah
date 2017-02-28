class AccountPlan < ActiveRecord::Base
  belongs_to :account
  belongs_to :plan
end
