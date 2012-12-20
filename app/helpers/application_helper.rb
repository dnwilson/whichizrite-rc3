module ApplicationHelper

	include AutoHtml
	include PrivatePub

	def full_title(page_title)
		base_title = "whichizrite"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	def message(sender, notification)
	  	if notification.notifiable_type == "new_follower"
	  	 	"#{link_to sender.username, user_path(sender)} is now following you."
	  	elsif notification.notifiable_type == "unfollowed"
	  		"#{link_to sender.username, user_path(sender)} is no longer following you."
	  	elsif notification.notifiable_type == "vote"
	  		alert_item = Story.find(notification.notifiable_id)
	  	 	"#{link_to sender.username, user_path(sender)} voted on your #{link_to "post", story_path(alert_item)}."
	  	elsif notification.notifiable_type == "comment"
	  		alert_item = Story.find(notification.notifiable_id)
	  		"#{link_to sender.username, user_path(sender)} commented on your #{link_to "post", story_path(alert_item)}."
	  	end 
  	end

	def devise_mapping
		@devise_mapping ||= Devise.mappings[:user]
	end

	def avatar_for(user, style)
	  	t = style
	  	image_tag(user.avatar.url(t), class: "avatar")
	end

	def icon_link_to(path, link, opts = {}, link_opts = {})
		classes = []
		l = link.to_s
		[:icon, :blank].each do |klass|
		  if k = opts.delete(klass)
		    classes << "#{klass}-#{k}"
		  end
		end
		classes << "enlarge" if opts.delete(:enlarge)
		opts[:class] ||= ""
		opts[:class] << "" << classes.join("")
		link_to content_tag(:i, "", opts), path, l, link_opts
	end
end
