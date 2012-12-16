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
  include AutoHtml
  include PgSearch
  
  attr_accessible :comment, :story_id, :comment_html

  belongs_to :story
  belongs_to :user

  has_many :notifications, :as => :notifiable

  acts_as_voteable
  
  validates :user_id, presence: true
  validates :story_id, presence: true
  validates :comment, presence: true, length: {minimum: 1}

  auto_html_for :comment do
    html_escape
    image
    youtube(:width => 438, :height => 246)
    soundcloud(:maxwidth => '438')
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

end
