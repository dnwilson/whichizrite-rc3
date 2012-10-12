class Vote < ActiveRecord::Base
  attr_accessible :story_id, :wir

  belongs_to :user
  belongs_to :story

  validates :user_id, uniqueness: {scope: :story_id}
end
