class TutorialsController < ApplicationController

	respond_to :js

	def index
		render json: {success: 200}
	end

	def new
	end

	def create
		user_id, title, description = params[:user_id], params[:title], params[:description]
		@user = User.find user_id
		@tutorial = @user.tutorials.create title: title, description: description
		link = user_tutorial_path(@user, @tutorial)
		render json: {link: link}.to_json
	end

	def show
	end

end
