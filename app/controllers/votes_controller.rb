class VotesController < ApplicationController
	before_filter :authenticate_user!

	def create
		@vote = current_user.votes.where(story_id: params[:vote][:story_id]).first
		@vote ||= current_user.votes.create(params[:vote])
		@vote.update_attributes(:wir => params[:vote][:wir])
		redirect_to :back
	end
end