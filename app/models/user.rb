class User < ApplicationRecord
  include Clearance::User

  has_many :items, :dependent => :destroy
end
