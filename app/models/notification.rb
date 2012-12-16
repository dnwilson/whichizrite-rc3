class Notification < ActiveRecord::Base
  attr_accessible :notifiable_id, :notifiable_type, :receiver_id, :sender_id

  belongs_to :notifiable, :polymorphic => true

  def self.alerts_for_me(user)
  	where("receiver_id = #{user.id} AND sender_id != #{user.id}")
  end

end
