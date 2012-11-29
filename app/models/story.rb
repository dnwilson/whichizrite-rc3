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
  attr_accessible :content, :title, :content_image
  belongs_to :user

  has_attached_file :content_image, styles: {small:"518x518>", large:"1500x1500>"},
                    default_url: "/assets/no-image.png",
                    url:  "/assets/images/users/:id/album/:basename_:style.:extension",
                    path: ":rails_root/public/assets/images/users/:id/album/:basename_:style.:extension"

  Paperclip.interpolates :name do |attachment, style|
    "#{attachment.instance.id}"
  end

  has_many :comments

  acts_as_voteable

  validates :user_id, presence: true
  validates :title, presence: true, length: {minimum: 5, maximum:50}
  validates :content, presence: true, length: {maximum: 320}
  validates_attachment :content_image, content_type: {:content_type => ["image/jpeg", "image/png", 
                                                        "image/bmp", "image/jpg"]}
                                #size: {less_than: 5.megabytes}

  default_scope order: 'stories.created_at DESC'

  #Returns stories from the users being followed by the given user
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end

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
