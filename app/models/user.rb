# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  admin                  :boolean          default(FALSE)
#  username               :string(255)
#  firstname              :string(255)
#  lastname               :string(255)
#  sex                    :string(255)
#  dob                    :datetime
#  bio                    :string(255)
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ActiveRecord::Base

  include PgSearch
  pg_search_scope :user_search, :against => [:username, :email],
                                :using => {
                                  tsearch: {:dictionary => 'simple', :prefix => true}
                                }
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  acts_as_voter

  acts_as_follower_plus
  acts_as_followable_plus

  has_many :notifications, :as => :notifiable
  
  
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model,
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username,
                  :sex, :name, :dob, :bio, :avatar, :country_name, :website, :location, 
                  :login, :private_followable, :provider, :uid, :admin, :profilepic

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  has_attached_file :avatar, styles: {xsml: "30x30#", thumb: "50x50#", small: "100x100#", 
                                      med:"350x350#", large:"1500x1500>"},
                    default_url: "/assets/no-image.png",
                    url:  "/assets/images/users/:id/album/:style/:basename.:extension",
                    path: ":rails_root/public/assets/images/users/:id/album/:style/:basename.:extension"

  has_many :stories, dependent: :destroy
  # has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  # has_many :followed_users, through: :relationships, source: :followed
  # has_many :reverse_relationships, foreign_key: "followed_id",
  #                                  class_name: "Relationship",
  #                                  dependent:  :destroy
  # has_many :followers, through: :reverse_relationships, source: :follower
  has_many :comments

  # before_save{|user| user.email = email.downcase}

  # VALID_EMAIL_REGEX = /\A[^@]+@[^@]+\z/
  # validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, 
  #                                   uniqueness: {case_sensitive:false}
  # validates :password, presence: true, length: {minimum: 6}
  # validates :password_confirmation, presence: true

  # validates :username, presence: true, length: {within: 8..20}
  
  validates_attachment :avatar, content_type: {content_type: ["image/jpeg", "image/png", 
                                                        "image/bmp", "image/jpg"]},
                                size: {less_than: 5.megabytes}
  

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.extra.raw_info.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           username: auth.info.nickname,
                           email:auth.info.email,
                           sex: auth.gender,
                           location: auth.info.location,
                           website: auth.link,
                           password:Devise.friendly_token[0,20]
                           )
    end
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end


### This is the correct method you override with the code above
### def self.find_for_database_authentication(warden_conditions)
### end 

  def feed
  	Story.from_users_followed_by(self)
  end

  def notify_follow(user)
    Notification.new(sender_id: self.id,
                       receiver_id: user.id,
                       notifiable_type: "new_follower").save 
  end

  def notify_unfollow(user)
    Notification.new(sender_id: self.id,
                       receiver_id: user.id,
                       notifiable_type: "unfollowed").save     
  end

  def notify_pending(user)
    Notification.new(sender_id: self.id,
                       receiver_id: user.id,
                       notifiable_type: "pending_user").save     
  end

  def notify_comment(story)
    Notification.new(sender_id: self.id,
                     receiver_id: story.user.id,
                     notifiable_id: story.id,
                     notifiable_type: "comment").save     
  end

  def notify_vote(story)
    Notification.new(sender_id: self.id,
                     receiver_id: story.user.id,
                     notifiable_id: story.id,
                     notifiable_type: "vote").save     
  end

  def alerts
    Notification.alerts_for_me(self)
  end
  # def to_param
  #   username
  # end
end