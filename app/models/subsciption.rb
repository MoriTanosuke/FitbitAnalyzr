class Subsciption < ActiveRecord::Base
  belongs_to :user
  validates :collection_path, :presence => true
  validates :subscription_id, :presence => true

  #TODO destroy subscription before deleting it
end
