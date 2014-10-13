require 'rails_helper'

describe 'doing tutorials' do 

	before do
		@user = create :user
		login_as @user
		@tutorial = @user.tutorials.create! title: "Ruby", description: "Kata", repo: "example-repo"
		Tutorial.any_instance.stub(:pomfile).and_return [{"commit"=>"acd1f9840afcab0f5c71d2d80e86173682eb2579", "instruction"=>"Pass this test!", "source"=>"lib/fizzbuzz.rb", "spec"=>"spec/fizzbuzz_spec.rb"}]
		Tutorial.any_instance.stub(:step).with(0).and_return "describe 'testing' do ; it 'works' do ; expect(a).to eq 1 ; end ; end"
	end

	it 'passes if I pass the test', js:true do 
		visit "/users/#{@user.username}/tutorials/#{@tutorial.repo}"
		sleep 5
		find('#source-code').set "a = 1"
		save_and_open_page
		click_button 'Submit!'
		sleep 5
		expect(page).to have_content '1 example, 0 failures'
	end

end