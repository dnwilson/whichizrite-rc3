require 'spec_helper'

describe "Pages" do
	# include Warden::Test::Helpers
	subject{page}

	shared_examples_for "all pages" do
		it {should have_selector('h1', text: heading)}
		it {should have_selector('title', text: full_title(page_title))}
	end

	describe "Home Page" do
		before {visit root_path}
		let(:heading) {'whichizrite'}
		let(:page_title) {''}

		it_should_behave_like "all pages"
		it {should_not have_selector('title', '|Home')}

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
					page.should have_selector("li##{item.id}", text: item.title)
				end
			end

			describe "follower/following counts" do
				let(:other_user) { FactoryGirl.create(:user) }
				before do
					other_user.follow!(user)
					visit root_path
				end

				it{should have_link("0 following", href: following_user_path(user))}
				it{should have_link("1 followers", href: followers_user_path(user))}
			end
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

		it_should_behave_like "all pages"
	end

	it "should have the right links on the layout" do
		visit root_path
		click_link "About"
		page.should have_selector'title', text:full_title('about')
		# click_link "Help"
		# page.should have_selector'title', text:full_title('Help')
		# click_link "Contact"
		# page.should have_selector'title', text:full_title('Contact')
		click_link "Home"
		click_link "Sign up now!"
		page.should have_selector'title', text:full_title('Sign up')
		click_link "logo"
		page.should have_selector'title', text:full_title('')		
	end
end
