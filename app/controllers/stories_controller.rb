class StoriesController < ApplicationController
    before_filter :authenticate_user!, only: [:create, :destroy]
    before_filter :correct_user, only: :destroy
    # before_filter :can_read, only: :show

	def show
        @story = Story.find(params[:id])
        if @story.user.private_followable = true && !current_user.following?(@story.user)
            flash[:notice] = "This is a private. Please follow user to view"
            redirect_to root_path
        else        
            if current_user.following?(@story.user) || current_user == @story.user
                @comment = Comment.new
            end
            respond_to do |format|
                format.html # show.html.erb
                format.json {render json: @story}
            end
        end
	end

	def create
		@story = current_user.stories.build(params[:story])
        if @story.anonymous?
            @story.user_id = User.find(2).id
            @story.origin_user_id = current_user.id
        else
            @story.origin_user_id = current_user.id
        end
        respond_to do |format|
        	if @story.save
                format.html {redirect_to root_path, :notice => "Story created!"}
                format.json {render json: @story, status: :created, location: @story}
                format.js
        	else
                @feed_items = []
                format.html {render 'pages/home'}
                format.json {render json: @story.errors, status: :unprocessable_entity}
                format.js {render 'pages/home'}
        	end
        end
	end

    # def comment
    #     @story = Story.find(params[:id])
    #     @comment = Comment.new        
    # end

    def vote_up
        @story = Story.find(params[:id])
        if @story.user.private_followable = true && !current_user.following?(@story.user)
            flash[:notice] = "You need to follow user in order to carry out this function"
            redirect_to user_path(@story.user)
        else
            current_user.vote_exclusively_for(@story)
            respond_to do |format|
                format.html { redirect_to @story }
                format.js
            end
        end
    end

    def vote_down
        @story = Story.find(params[:id])
        if @story.user.private_followable = true && !current_user.following?(@story.user)
            flash[:notice] = "You need to follow user in order to carry out this function"
            redirect_to user_path(@story.user)
        else
            current_user.vote_exclusively_against(@story)
            respond_to do |format|
                format.html { redirect_to @story}
                format.js
            end
        end
    end

    def unvote
        if @story.user.private_followable = true && !current_user.following?(@story.user)
            flash[:notice] = "You do not have permission to carry out this function."
            redirect_to root_path
        else
            @story = Story.find(params[:id])
            current_user.unvote_for(@story)
            respond_to do |format|
                format.html { redirect_to @story}
                format.js
            end
        end
    end

    def index
        @pg_search_documents = PgSearch.multisearch(params[:query]) #.paginate(page: params[:page])
    end

    
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
            @story = current_user.id == Story.find_by_id(params[:id]).origin_user_id
            redirect_to root_url if @story.nil? 
        end

        # def can_read
        #     @story = current_user.following?(Story.find_by_id(params[:id]).user) || current_user == Story.find_by_id(params[:id]).user
        #     redirect_to root_url, flash[:failure] = "You do not have sufficient permissions to view" if @story.nil? 
        # end
end