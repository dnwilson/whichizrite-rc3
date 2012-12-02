FactoryGirl.define do
	factory :user do
		sequence(:email) {|n| "person_#{n}@example.com"}
		sequence(:username) {|n| "person_#{n}"}
		password				"foobar"
		password_confirmation	"foobar"

		factory :admin do
			admin true
		end
	end

	factory :story do
		title 		"Test title"
		content		"Lorem ipsum"
		user
	end

	factory :comment do
		comment		"Lorem ipsum"
		user
	end
end
