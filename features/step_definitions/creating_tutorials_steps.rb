Given(/^I am logged in$/) do
	@user = create :user 
	login_as @user
end

Given(/^I am on the dashboard page$/) do
	visit '/dashboard'
end

Given(/^I click to create a new tutorial$/) do
	click_link 'Create A Tutorial'
end

When(/^I click on a repository of mine$/) do
	save_and_open_page
	click_link 'Example Repo'
end

Then(/^I should be on the tutorial page$/) do
end

Then(/^I should be given a list of instructions$/) do
end
