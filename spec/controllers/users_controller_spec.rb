require 'spec_helper'

describe UsersController do

	before :each do
		request.env['devise.mapping'] = Devise.mappings[:user]
	end
end