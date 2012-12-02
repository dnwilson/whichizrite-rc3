require 'spec_helper'

describe "StoryPages" do
  
  subject{page}

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "story creation" do
  	before {visit root_path}

  	describe "with invalid information" do
  		
  		it "should not create a story" do
  			expect { click_button "Post" }.should_not change(Story, :count)
  		end

  		describe "error messages" do
  			before{click_button "Post"}
  			it {should have_content('title')}
  		end
  	end

  	describe "with valid information" do
  		
  		before {
        fill_in 'story_title', with: "Lorem ipsum"
        fill_in 'story_content', with: "Some random content"
      }

  		it "should create a story" do
  			expect{click_button "Post"}.should change(Story, :count).by(1)
  		end
  	end
  end

  describe "story destruction" do
    before {FactoryGirl.create(:story, user: user)}

    describe "as correct user" do
      before {visit root_path}

      it "should delete a story" do
        expect {click_link "delete"}.should change(Story, :count).by(-1)
      end
    end
  end
end 
