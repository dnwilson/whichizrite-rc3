require 'spec_helper'

describe User do

	before{@user = User.new(email: "user@example.com", password: "foobar",
							password_confirmation: "foobar")}

	subject{@user}

	it{should respond_to(:email)}
	it{should respond_to(:password)}
	it{should respond_to(:password_confirmation)}
	it{should respond_to(:admin)}

	it{should be_valid}
	it{should_not be_admin}
end