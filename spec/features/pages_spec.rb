require 'spec_helper'

include Warden::Test::Helpers

Warden.test_mode!

describe "Pages" do
	# include Warden::Test::Helpers
	subject{page}

	describe "Home Page" do

		before {visit root_path}
		let(:heading) {'whichizrite'}
		let(:page_title) {''}

		it {should_not have_selector('title', '| Home')}

		describe "for signed-in users" do
			let(:user) { FactoryGirl.create(:user) }

			before do
				FactoryGirl.create(:story, user: user, title: "Some ipsum", origin_user_id: user.id)
				FactoryGirl.create(:story, user: user, content: "Lorem ipsum", origin_user_id: user.id)
				FactoryGirl.create(:story, user: user, title: "My title", origin_user_id: user.id)
				FactoryGirl.create(:story, user: user, content: "Dolor sit amet", origin_user_id: user.id)
				sign_in user
				visit root_path
			end

			it "should render the user's feed" do
				user.feed.each do |item|
					expect(page).to have_selector("li##{item.id}", text: item.title)
				end
			end

			# describe "follower/following counts" do
			# 	let(:other_user) { FactoryGirl.create(:user) }
			# 	before do
			# 		other_user.follow(user)
			# 		visit root_path
			# 	end

			# 	# it{should have_link("0 following", href: following_user_path(user))}
			# 	# it{should have_link("1 followers", href: followers_user_path(user))}
			# end
		end
	end

	# describe "Help Page" do
	# 	before {visit help_path}
	# 	let(:heading) {'Help'}
	# 	let(:page_title) {'Help'}

	# 	it_should_behave_like "all pages"
	# end

	describe "About Page" do
		before {visit about_path}
		let(:heading) {'About us'}
		let(:page_title) {'about'}

	end

end
