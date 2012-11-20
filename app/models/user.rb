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
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  acts_as_voter
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username,
                  :sex, :name, :dob, :bio, :avatar, :country_name, :website, :location, :login

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login
  
  has_attached_file :avatar, styles: {xsml: "30x30#", thumb: "50x50#", small: "150x150#", 
                                      med:"500x500#", large:"1500x1500>"},
                    default_url: "/assets/no-image.png",
                    url:  "/assets/images/users/:id/:basename_:style.:extension",
                    path: ":rails_root/public/assets/images/users/:id/:basename_:style.:extension"

  Paperclip.interpolates :name do |attachment, style|
    "#{attachment.instance.id}"
  end

  has_many :stories, dependent: :destroy
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

### This is the correct method you override with the code above
### def self.find_for_database_authentication(warden_conditions)
### end 

  def feed
  	Story.all
  end

end
