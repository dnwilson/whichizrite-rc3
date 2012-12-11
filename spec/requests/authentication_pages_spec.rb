require 'spec_helper'

describe "AuthenticationPages" do
  subject{page}

  # describe "login page" do
  #   before { visit login_path }

  #   it { should have_selector('h1',    text: 'Sign in') }
  #   it { should have_selector('title', text: 'Sign in') }
  # end

  # describe "login" do
  # 	before{visit login_path}

  # 	describe "with invalid information" do
  # 		before {click_button "Sign in"}
  		
  # 		it{should have_selector('title', text:'Sign in')}
  # 		it{should have_selector('div.alert.alert-error', text:'Invalid')}

  # 		describe "after visiting another page" do
  # 			before {click_link "Home"}
  # 			it {should_not have_selector('div.alert.alert-error')}
  # 		end
  # 	end

  # 	describe "with valid information" do
  # 		let(:user) {FactoryGirl.create(:user)}
  # 		before do
  # 			fill_in "Email", 	with: user.email 
  # 			fill_in "Password", with: user.password
  #       click_button "Sign in" 
  # 		end

  # 		# it {should have_selector('title', text: user.name)}

  #     it {should have_link('Users', href: users_path)}
  # 		it {should have_link('Profile', href: user_path(user))}
  #     it {should have_link('Settings', href: edit_user_path(user))}
  # 		it {should have_link('Sign out', href: logout_path)}
      
  # 		it {should_not have_link('Sign in', href: login_path)}

  # 		describe "followed by logout" do
  # 			before{click_link "Sign out"}
  # 			it {should have_link('Sign in')}  			
  # 		end
  # 	end
  # end

  # describe "authorization" do

  #   describe "for non-signed in users" do
      
  #     let(:user){FactoryGirl.create(:user)}

  #     describe "when attempting to visit a protected page" do
  #       before do
  #         visit edit_user_path(user)
  #         fill_in "Email",    with: user.email
  #         fill_in "Password", with: user.password
  #         click_button "Sign in"
  #       end

  #       describe "after logging in" do
          
  #         it "should render the desired protected page" do
  #           page.should have_selector('title', text: 'Edit user')
  #         end

  #         describe "when logging in again" do
  #           before do
  #             delete logout_path
  #             visit login_path
  #             fill_in "Email",    with: user.email
  #             fill_in "Password", with: user.password
  #             click_button "Sign in"
  #           end

  #           # it "should render the default(profile) page" do
  #           #   page.should have_link('title', text: user.name)
  #           # end
  #         end
  #       end
  #     end

  #     describe "in the Users controller" do
        
  #       describe "visiting the edit page" do
  #         before{visit edit_user_path(user)}
  #         it{should have_selector('title', text: 'Sign in')}
  #       end

  #       describe "submitting to the update action" do
  #         before {put user_path(user)}
  #         specify{response.should redirect_to(login_path)}          
  #       end

  #       describe "visiting the user index" do
  #         before {visit users_path}
  #         it {should have_selector('title', text: 'Sign in')}
  #       end

  #       describe "visiting the following page" do
  #         before{visit following_user_path(user)}
  #         it{should have_selector('title', text: 'Sign in')}
  #       end

  #       describe "visting the followers page" do
  #         before{visit followers_user_path(user)}
  #         it{should have_selector('title', text: 'Sign in')}
  #       end
  #     end

  #     describe "in the Stories controller" do
        
  #       describe "submitting to the create action" do
  #         before {post stories_path}
  #         specify {response.should redirect_to(login_url)}
  #       end

  #       describe "submitting to the destroy action" do
  #         before{delete story_path(FactoryGirl.create(:story))}
  #         specify {response.should redirect_to(login_url)}
  #       end
  #     end

  #     # describe "in the Relationships controller" do
  #     #   describe "submitting to the create action" do
  #     #     before{post relationships_path}
  #     #     specify{response.should redirect_to(login_url)}
  #     #   end

  #     #   describe "submitting to the destroy action" do
  #     #     before{delete relationship_path(1)}
  #     #     specify{response.should redirect_to(login_url)}
  #     #   end
  #     # end
  #   end 

  #   describe "as wrong user" do
  #     let(:user){FactoryGirl.create(:user)}
  #     let(:wrong_user){FactoryGirl.create(:user, email: "wrong@example.com")}

  #     before {sign_in user}

  #     describe "visiting Users#edit page" do
  #       before {visit edit_user_path(wrong_user)}
  #       it {should have_selector('title', text: full_title(''))}        
  #     end

  #     describe "submitting a PUT request to the Users#update action" do
  #       before {put user_path(wrong_user)}
  #       specify {response.should redirect_to(root_path)}
  #     end
  #   end

  #   describe "as non-admin user" do
  #     let(:user){FactoryGirl.create(:user)}
  #     let(:none_admin){FactoryGirl.create(:user)}

  #     before {sign_in none_admin}

  #     describe "submitting a DELETE request to the Users#destroy action" do
  #       before{delete user_path(user)}
  #       specify{response.should redirect_to(root_path)}
  #     end
  #   end   
  # end
end