class UserObserver < ActiveRecord::Observer

	observe :user

	def after_follow(user)
		Notification.new(:sender_id => current_user.id,
							:receiver => user.id,
							:notifiable_type => "new_follower").save
	end

	def after_unfollow(user)
		Notification.new(:sender_id => current_user.id,
							:receiver => user.id,
							:notifiable_type => "unfollowed").save
	end
end
