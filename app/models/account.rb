class Account < ActiveRecord::Base
  has_many :transactions
  has_many :account_users
  has_many :users, through: :account_users
end
