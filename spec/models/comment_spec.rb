# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  story_id   :integer
#  comment    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Comment do
  let(:user){FactoryGirl.create(:user)}
	before {@comment = user.comments.create(comment: "Lorem ipsum")}

	subject{@comment}

	it{should respond_to(:comment)}
	it{should respond_to(:comment_html)}
	it{should respond_to(:user)}
	it{should respond_to(:story)}
	it{should respond_to(:votes)}
	it{should respond_to(:story_id)}
	its(:user){should == user}

	# it{should be_valid}
end
