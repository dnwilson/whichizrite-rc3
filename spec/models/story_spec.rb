# == Schema Information
#
# Table name: stories
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string(255)
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Story do

	let(:user){FactoryGirl.create(:user)}
	before {@story = user.stories.build(title: "Test title", content: "Lorem ipsum")}

	subject{@story}

	it{should respond_to(:title)}
	it{should respond_to(:content)}
	it{should respond_to(:user_id)}
	it{should respond_to(:user)}
	its(:user){should == user}

	it{should be_valid}

	describe "accessible attributes" do
		it "should not allow access to user_id" do
			expect do
				Story.new(user_id: user.id)
			end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end

	describe "when user_id is not present" do
		before{@story.user_id = nil}
		it{should_not be_valid}
	end
	
	describe "with blank details" do
		before{@story.content = nil}
		it{should_not be_valid}
	end

	describe "with blank title" do
		before{@story.title = nil}
		it{should_not be_valid}
	end
end
