# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	email "bla@bla.com"
  	password "12345678"
  	password_confirmation "12345678"
  	username "blarfdssdfsfds"
  end
end
