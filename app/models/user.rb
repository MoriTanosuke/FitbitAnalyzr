class User < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  has_secure_password
  has_one :fitbit, :dependent => :destroy
end
