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

require 'spec_helper'

describe User do

	before{@user = User.new(email: "user@example.com", password: "foobar",
							password_confirmation: "foobar")}

	subject{@user}

	it{should respond_to(:email)}
	it{should respond_to(:password)}
	it{should respond_to(:password_confirmation)}
	it{should respond_to(:admin)}
	it{should respond_to(:username)}
	it{should respond_to(:avatar)}
	it{should respond_to(:hide)}
	it{should respond_to(:sex)}
	it{should respond_to(:name)}
	it{should respond_to(:dob)}
	it{should respond_to(:bio)}
	it{should respond_to(:country_name)}
	it{should respond_to(:website)}
	it{should respond_to(:location)}
	it{should respond_to(:login)}
	it{should respond_to(:feed)}
	it{should respond_to(:stories)}
	it{should respond_to(:votes)}
	it{should respond_to(:comments)}


	it{should be_valid}
	it{should_not be_admin}

	describe "story associations" do
    
		before {@user.save}
		let!(:older_story) do
			FactoryGirl.create(:story, user: @user, created_at: 1.day.ago)
		end
		let!(:newer_story) do
			FactoryGirl.create(:story, user: @user, created_at: 1.hour.ago)
		end

		it "should have the right stories in the right order" do
			@user.stories.should == [newer_story, older_story]
		end

		it "should destroy associated stories" do
			stories = @user.stories
			@user.destroy
			stories.each do |story|
				Story.find_by_id(story.id).should be_nil
			end
		end

		describe "status" do
			let(:unfollowed_post) do
				FactoryGirl.create(:story, user: FactoryGirl.create(:user))
			end

			let(:followed_user) { FactoryGirl.create(:user) }

			before do
				@user.follow!(followed_user)
				3.times {followed_user.stories.create!(title: "Lorem ipsum", content: "Lorem ipsum")}
			end

			# its(:feed) { should include(newer_story) }
			# its(:feed) { should include(older_story) }
			its(:feed) { should_not include(unfollowed_post) }
			its(:feed) do
				followed_user.stories.each do |story|
				  should include{ story }
				end
			end
		end
	end
end
