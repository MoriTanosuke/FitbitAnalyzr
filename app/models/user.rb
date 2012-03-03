class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class User < ActiveRecord::Base
  validates :email, :presence => true, :uniqueness => true, :email => true
  has_secure_password
  has_one :fitbit, :class_name => "FitbitToken", :dependent => :destroy
  has_many :sleeps
  has_many :measurements
end
