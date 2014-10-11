class HomeController < ApplicationController

	def index
		@tutorials = Tutorial.available
	end


end
