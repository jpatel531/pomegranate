class TutorialsController < ApplicationController

	before_action :authenticate_user!
	before_action :check_tutorial_owner, only: [:index, :create, :new]

	def new
	end

	def index
		@user = User.find_by_username params[:user_id]
	end

	def create
		user_id, title, description, repo = params[:user_id], params[:title], params[:description], params[:repo]
		@user = User.find_by_username user_id
		@tutorial = @user.tutorials.create title: title, description: description, repo: repo
		link = user_tutorial_path(@user, @tutorial)
		render json: {link: link}.to_json
	end

	def show
		@tutorial = Tutorial.find_by_repo params[:id]
		if @tutorial.pomfile
			render "tutorials/show"
		else 
			render "tutorials/instructions"
		end
	end

	def steps
		@user = User.find_by_username params[:user_id]
		@tutorial = @user.tutorials.find_by_repo params[:id]
		step_number = params[:step_number].to_i || 0
		render json: {spec: @tutorial.step(step_number), instruction: @tutorial.pomfile[step_number]["instruction"]}
	end

	def test_runner
		source, test = params[:source], params[:test]
		exception = check_for_exceptions source
		if exception
			render json: {exception: exception.gsub(/ for #<(.*?)\>/, "")} 
		else
			contents = source + "\n" + test
			File.open('tmp/test.rb', 'w') { |f| f.write contents}
			output = `rspec tmp/test.rb -fj`
			`rm tmp/test.rb`
			render json: output
		end
	end

	private

	def check_for_exceptions file
		begin
			eval file
		rescue Exception => e
			return e.message
		end
		return nil
	end

	def check_tutorial_owner
		@user = User.find_by_username params[:user_id]
		redirect_to root_path if current_user != @user
	end

end
