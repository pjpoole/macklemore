class Transaction < ActiveRecord::Base
  belongs_to :account
  has_many :splits
end
