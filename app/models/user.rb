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
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username,
                  :sex, :firstname, :lastname, :dob, :bio
  # attr_accessible :title, :body

  has_many :stories, dependent: :destroy
  has_many :comments

  # before_save{|user| user.email = email.downcase}

  # VALID_EMAIL_REGEX = /\A[^@]+@[^@]+\z/
  # validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, 
  #                                   uniqueness: {case_sensitive:false}
  # validates :password, presence: true, length: {minimum: 6}
  # validates :password_confirmation, presence: true

  # validates :username, presence: true, length: {within: 8..20}


  def feed
  	Story.all
  end
end
