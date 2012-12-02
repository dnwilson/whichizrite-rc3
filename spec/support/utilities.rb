include ApplicationHelper

#Returns the full title on a per page basis
def full_title(page_title)
	base_title = "whichizrite"
	if page_title.empty?
		base_title
	else
		"#{base_title} | #{page_title}"
	end
end

def sign_in(user)
	visit login_path
	fill_in "user_login",	with: user.email 
	fill_in "user_password", with: user.password 
	click_button "Sign in"
	#Sign in when not using Capybara as well
	# cookies[:remember_token] = user.remember_token
end