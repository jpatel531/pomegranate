class TutorialsController < ApplicationController

	def new
	end

	def index
		@user = User.find params[:user_id]
	end

	def create
		user_id, title, description, repo = params[:user_id], params[:title], params[:description], params[:repo]
		@user = User.find user_id
		@tutorial = @user.tutorials.create title: title, description: description, repo: repo
		link = user_tutorial_path(@user, @tutorial)
		render json: {link: link}.to_json
	end

	def show
		@tutorial = Tutorial.find params[:id]
		@tutorial.pomfile ? (render "tutorials/show") : (render "tutorials/instructions")
	end

	def steps
		@user = User.find params[:user_id]
		@tutorial = @user.tutorials.find params[:id]
		step_number ||= 0
		render json: {spec: @tutorial.step(step_number), instruction: @tutorial.pomfile[step_number]["instruction"]}
	end

	def test_runner
		source, test = params[:source], params[:test]
		contents = source + "\n" + test
		File.open('tmp/test.rb', 'w') { |f| f.write contents}
		output = `rspec tmp/test.rb -fj`
		`rm tmp/test.rb`
		render json: output
	end

end
