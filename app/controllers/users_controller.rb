class UsersController < ApplicationController

	def repos
		render json: current_user.repos.to_json
	end

end
