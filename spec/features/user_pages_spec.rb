require 'spec_helper'

include Warden::Test::Helpers

Warden.test_mode!

describe "UserPages" do

	# subject{page}

	# describe "index page" do

	# 	let(:user) {FactoryGirl.create(:user)}

	# 	before(:all){30.times{FactoryGirl.create(:user)}}
	# 	after(:all) {User.delete_all}

	# 	before(:each) do 
	# 		visit login_path
	# 		login_as(user, :scope => :user) 
	# 		visit users_path
	# 	end

	# 	it {should have_title('whichizrite | All users')}
	# 	it {should have_selector('h1', text: 'All users')}

	# 	describe "pagination" do

	# 		it {should have_selector('div.pagination')}
			
	# 		it "should list each user" do
	# 			User.paginate(page:1).each do |user|
	# 				page.should have_selector('li', text: user.name)
	# 			end
	# 		end
	# 	end
	# end

	# describe "signup page" do
	# 	before {visit register_path}

	# 	it {should have_selector('h2', text: 'Sign up')}
	# 	it {should have_title(full_title('Sign up'))}
	# end

	# describe "profile page" do
	# 	#Code to make a user variable
	# 	let (:user){FactoryGirl.create(:user)}
	# 	let!(:s1) {FactoryGirl.create(:story, user_id: user.id, title: "barand", content: "Foo")}
	# 	let!(:s2) {FactoryGirl.create(:story, user_id: user.id, title: "foobar", content: "Bar")}
		
	# 	before(:each) do 
	# 		visit login_path
	# 		login_as(user, :scope => :user)
	# 	end

	# 	before{visit user_path(user)}

	# 	it {should have_selector('h1', text: user.name)}
	# 	it {should have_selector('h1', text: user.name)}

	# 	describe "stories" do
	# 		it {should have_content(s1.content)}
	# 		it {should have_content(s2.content)}
	# 		it {should have_content(user.stories.count)}
	# 	end

	# 	describe "private user" do
	# 		let(:private_user) { FactoryGirl.create(:user, private_followable: true) }

	# 		before do 
	# 			visit login_path
	# 			login_as(user, :scope => :user)
	# 			visit user_path(private_user)
	# 		end

	# 		it "should not be displayed if user is private" do
	# 			should have_selector('h1', text: "This is a private user")
	# 		end
	# 	end

	# 	it {should have_selector('h1', text: user.name)}
	# 	it {should have_selector('h1', text: user.name)}

	# 	describe "follow/unfollow buttons" do

	# 		let(:other_user) { FactoryGirl.create(:user) }
	# 		before { login_as(user, :scope => :user)}
			
	# 		describe "following a user" do
	# 			before{visit user_path(other_user)}

	# 			it "should increment the followed user count" do
	# 				expect do
	# 					click_button "Follow"
	# 				end.to change(user.follows, :count).by(1)
	# 			end

	# 			it "should increment the user's followers count" do
	# 				expect do
	# 					click_button "Follow"
	# 				end.to change(other_user.followers, :count).by(1)
	# 			end

	# 			describe "toggling the button" do
	# 				before{click_button "Follow"}
	# 				it{should have_selector('input', value: 'Unfollow')}
	# 			end
	# 		end

	# 		describe "unfollowing a user" do
	# 			before do
	# 				user.follow!(other_user)
	# 				visit user_path(other_user)
	# 			end

	# 			it "should decrement the followed user count" do
	# 				expect do
	# 					click_button "Unfollow"
	# 				end.to change(user.followed_users, :count).by(-1)
	# 			end

	# 			it "should decrement the user's followers count" do
	# 				expect do
	# 					click_button "Unfollow"
	# 				end.to change(other_user.followers, :count).by(-1)
	# 			end
					
	# 			describe "toggling the button" do
	# 				before{click_button "Unfollow"}
	# 				it{should have_selector('input', value: 'Follow')}
	# 			end
	# 		end
	# 	end
	# end

	# describe "signup" do
	# 	before{visit register_path}

	# 	let(:submit){"Create my account"}

	# 	describe "with invalid information" do
	# 		it "should not create a user" do
	# 			expect{click_button submit}.not_to change(User, :count)
	# 		end

	# 		describe "after submission" do
	# 			before{click_button submit}

	# 			it {should have_selector('title', text:'Sign up')}
	# 			it {should have_content('error')}
	# 		end		
	# 	end

	# 	describe "with valid information" do
	# 		before do
	# 			fill_in "user_name",					with:"Example User"
	# 			fill_in "user_email",					with:"user@example.com"
	# 			fill_in "user_username",				with:"exampleuser"
	# 			fill_in "user_password", 				with:"foobar"
	# 			fill_in "user_password_confirmation", 	with:"foobar"
	# 		end

	# 		it "should create a user" do
	# 			expect{click_button submit}.to change(User, :count).by(1)				
	# 		end

	# 		describe "after saving the user" do
	# 			before{click_button submit}
	# 			let(:user){User.find_by_email('user@example.com')}

	# 			it {should have_selector('h2', text: user.username)}
	# 			it {should have_selector('div.alert.alert-notice', text:'Welcome!')}
	# 			it {should have_link('Sign out')}
	# 		end
	# 	end		
	# end

	# describe "edit" do
	#     let(:user) { FactoryGirl.create(:user) }

	#     before do
	# 		login_as(user, :scope => :user) 
	# 		visit settings_path(user)
	#     end

	#     describe "page" do
	# 	    it { should have_selector('h2',    text: "Profile") }
	# 	    it { should have_selector('title', text: "Profile settings") }
	#     end

	#     # describe "with invalid information" do
	#     # 	before { click_button "Update" }

	#     # 	it { should have_content('error') }
	#     # end

	#     describe "with valid information" do
	# 	    let(:new_name)		{ "New Name" }
	# 	    let(:new_location)	{ "My Place, My City" }
	# 	    let(:new_website)	{ "www.myplace.com" }
	# 	    let(:new_bio)		{ "This is my bio" }
	# 	    let(:new_username)	{ "example1" }
	# 	    before do
	# 	        fill_in "user_name",             		with: new_name
	# 	        fill_in "user_location",            	with: new_location
	# 	        fill_in "user_website",   	         	with: new_website
	# 	        fill_in "user_bio",            			with: new_bio
	# 	        fill_in "user_username",				with: new_username
	# 	        click_button "Update"
	# 	    end

	# 	    it { should have_selector('h1', text: new_name) }
	# 	    it { should have_selector('div.alert.alert-notice') }
	# 	    it { should have_link('Sign out', href: logout_path) }
	# 	    specify { user.reload.username.should  == new_username }
	#     end	  
	# end

	# describe "following/followers" do
	# 	let(:user) { FactoryGirl.create(:user) }
	# 	let(:other_user) { FactoryGirl.create(:user) }
	# 	before { user.follow!(other_user)}

	# 	describe "followed users" do
	# 		before do
	# 			login_as(user)
	# 			visit following_user_path(user)
	# 		end

	# 		it{should have_selector('title', text: full_title('Following'))}
	# 		it{should have_selector('h3', text:'Following')}
	# 		it{should have_link(other_user.username, href: user_path(other_user))}
	# 	end

	# 	describe "followers" do
	# 		before do
	# 			sign_in other_user
	# 			visit followers_user_path(other_user)
	# 		end

	# 		it{should have_selector('title', text: full_title('Followers'))}
	# 		it{should have_selector('h3', text: 'Followers')}
	# 		it{should have_link(user.username, href: user_path(user))}
	# 	end
	# end
end
