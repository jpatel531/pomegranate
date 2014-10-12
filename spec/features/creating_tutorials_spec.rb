require 'rails_helper'

describe 'creating tutorials' do 

	before do
		@user = create :user
		# @user.stub(:repos).and_return [{name: "airport-test", description: "test 3 at makers academy"}]
		login_as @user
	end

	it 'gives you a list of what to do', js:true do 
		User.any_instance.stub(:repos).and_return [{name: "airport-test", description: "test 3 at makers academy"}]
		visit "/users/#{@user.username}/tutorials"
		click_link "Create A Tutorial"
		click_link "airport-test"
		save_and_open_page
		fill_in 'tutorial-title', with: "Airport Kata"
		fill_in 'tutorial-description', with: "An exercise in object-oriented programming"
		click_button 'Create Tutorial'
		expect(page).to have_content "Use the pomegranate-cli gem to create tutorial steps out of your commits. Then come back here."
	end

end