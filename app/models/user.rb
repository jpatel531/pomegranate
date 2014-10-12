require 'octokit'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:github]

  has_many :tutorials

  has_many :progressions


	def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	    user.email = auth.info.email
	    user.password = Devise.friendly_token[0,20]
      user.avatar = auth.info.image
      user.username = auth.info.nickname

	    # user.name = auth.info.name   # assuming the user model has a name
	    # user.image = auth.info.image # assuming the user model has an image
	  end
	end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def repos
    client = Octokit::Client.new client_id: Rails.application.secrets.github_id, client_secret: Rails.application.secrets.github_secret
    pages = [current_page = client.user(username).rels[:repos].get]
    until !current_page.rels[:next]
      pages += [current_page = current_page.rels[:next].get]
    end
    list_of_repos = pages.map(&:data).flatten.map {|repo| {name: repo[:name], description: repo[:description] } }
    list_of_repos.reject {|repo| tutorials.any? {|tutorial| tutorial.repo == repo}}
  end

  def repos=(value)
  end

  def to_param
    username
  end



end
