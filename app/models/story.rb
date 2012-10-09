class Story < ActiveRecord::Base
  attr_accessible :details, :title, :user_id
  belongs_to :user
end
