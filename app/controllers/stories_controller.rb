class StoriesController < ApplicationController
    before_filter :authenticate_user!, only: [:create, :destroy]
    before_filter :correct_user, only: :destroy

	def show
        @story = Story.find(params[:id])
        @comment = Comment.new
	end

	def create
		@story = current_user.stories.build(params[:story])
        respond_to do |format|
        	if @story.save
                format.html {redirect_to @story, notice: "Story successfully created"}
        		format.json {render json: @story, status: :created, location: @story }
        	else
                @feed_items = []
                render 'pages/index'
        	end
        end
	end

    def list
        @stories = Story.all
    end

    def edit
        @story = Story.find(params[:id])
    end

    def new
        @story = Story.new

        respond_to do |format|
            format.html
            format.json{render json: @story}
        end
    end

    def destroy
        @story = Story.find(params[:id])
        @story.destroy

        respond_to do |format|
            format.html {redirect_to stories_url}
            format.json {head :no_content}
        end
    end

    def index
        @stories = Story.all
    end

    private

        def correct_user
            @story = current_user.stories.find_by_id(params[:id])
            redirect_to root_url if @story.nil?
        end
end