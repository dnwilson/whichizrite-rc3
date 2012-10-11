# == Schema Information
#
# Table name: stories
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string(255)
#  details    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Story < ActiveRecord::Base
  attr_accessible :details, :title
  belongs_to :user

  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 50}
  validates :details, presence: true

  default_scope order: 'stories.created_at DESC'
end
