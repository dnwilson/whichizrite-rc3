class Vote < ActiveRecord::Base
  attr_accessible :story_id, :user_id, :wir
end
