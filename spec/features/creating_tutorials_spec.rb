require 'rails_helper'

describe 'creating tutorials' do 

	before do
		@user = create :user
		login_as @user
		User.any_instance.stub(:repos).and_return [{name: "airport-test", description: "test 3 at makers academy"}]
		visit "/users/#{@user.username}/tutorials"
		click_link "Create A Tutorial"
		click_link "airport-test"
		fill_in 'tutorial-title', with: "Airport Kata"
		fill_in 'tutorial-description', with: "An exercise in object-oriented programming"
		click_button 'Create Tutorial'
	end

	context 'without a pomegranate.json file in the repo' do
		it 'gives you a list of what to do', js:true do 
			expect(page).to have_content "Use the pomegranate-cli gem to create tutorial steps out of your commits. Then come back here."
		end
	end

	context 'with a pomegranate.json file in the repo' do 
		it 'shows you your tutorial', js:true do
			sleep 5
			Tutorial.any_instance.stub(:pomfile).and_return [{"commit"=>"acd1f9840afcab0f5c71d2d80e86173682eb2579", "instruction"=>"Pass this test!", "source"=>"lib/fizzbuzz.rb", "spec"=>"spec/fizzbuzz_spec.rb"}]
			Tutorial.any_instance.stub(:step).with(0).and_return "require 'fizzbuzz'\n\ndescribe 'Fizzbuzz' do \n\n\tit 'knows when a number is divisible by 3' do \n\t\texpect(divisible_by_three? 3).to be_true\n\tend\n\nend"
			visit current_path
			expect(page).to have_content "Pass this test!"
			expect(page).to have_content "describe 'Fizzbuzz' do"
		end
	end

end