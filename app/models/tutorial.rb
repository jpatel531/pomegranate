class Tutorial < ActiveRecord::Base

	scope :available, -> { all.select {|tutorial| tutorial.pomfile} }

	belongs_to :user

	def client
		@client ||= Octokit::Client.new client_id: Rails.application.secrets.github_id, client_secret: Rails.application.secrets.github_secret
	end

	def repo_full_name
		"#{user.username}/#{repo}"
	end

	def pomfile
		begin
			JSON.parse client.contents(repo_full_name, path: "pomegranate.json", accept: "application/vnd.github-blob.raw")
		rescue Octokit::NotFound => e
			nil
		end
	end

	def step number
		pom_step = pomfile[number]
		client.contents repo_full_name, 
			path: pom_step["spec"],
			accept: "application/vnd.github-blob.raw",
			ref: pom_step["commit"]
	end

	def to_param
		repo
	end


end
