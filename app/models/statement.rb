class Statement < ActiveRecord::Base
  has_many :transactions
end
