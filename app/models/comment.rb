# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  story_id   :integer
#  comment    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  attr_accessible :comment

  belongs_to :story
  belongs_to :user

  validates :user_id, presence: true
  validates :story_id, presence: true
  validates :comment, presence: true
end
