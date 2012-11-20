# == Schema Information
#
# Table name: stories
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string(255)
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Story < ActiveRecord::Base
  attr_accessible :content, :title
  belongs_to :user

  has_many :comments

  acts_as_voteable

  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 50}
  validates :content, presence: true

  default_scope order: 'stories.created_at DESC'

  def votecount
  	if self.votes_for == self.votes_against 
	   self.votes_for - self.votes_against
	elsif self.votes_for > self.votes_against 
	   self.votes_for - self.votes_against 
	else
	   self.votes_against - self.votes_for
	end 
  end

end
