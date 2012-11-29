class StoriesController < ApplicationController
    before_filter :authenticate_user!, only: [:create, :destroy]
    before_filter :correct_user, only: :destroy

	def show
        @story = Story.find(params[:id])
        @comment = Comment.new
        respond_to do |format|
            format.html # show.html.erb
            format.json {render json: @story}
        end
	end

	def create
		@story = current_user.stories.build(params[:story])
        respond_to do |format|
        	if @story.save!
                format.html {redirect_to root_path}
                format.js
        	else
                @feed_items = []
                render 'pages/index'
        	end
        end
	end

    # def comment
    #     @story = Story.find(params[:id])
    #     @comment = Comment.new        
    # end

    def vote_up
        @story = Story.find(params[:id])
        current_user.vote_exclusively_for(@story)
        respond_to do |format|
            format.html { redirect_to @story }
            format.js
        end
    end

    def vote_down
        @story = Story.find(params[:id])
        current_user.vote_exclusively_against(@story)
        respond_to do |format|
            format.html { redirect_to @story}
            format.js
        end
    end

    def unvote
        @story = Story.find(params[:id])
        current_user.unvote_for(@story)
        respond_to do |format|
            format.html { redirect_to @story}
            format.js
        end 
    end

    # def index
    #     @stories = Story.all
    # end

    # def edit
    #     @story = Story.find(params[:id])
    # end

    def destroy
        @story = Story.find(params[:id])
        @story.destroy

        respond_to do |format|
            format.html {redirect_to :back}
            format.json {head :no_content}
        end
    end

    private

        def correct_user
            @story = current_user.stories.find_by_id(params[:id])
            redirect_to root_url if @story.nil?
        end
end