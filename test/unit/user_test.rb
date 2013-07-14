require 'test_helper'

class UserTest < ActiveSupport::TestCase

	test "a user should enter a first name" do
		user = User.new
		assert !user.save
		assert !user.errors[:first_name].empty?
	end
	
	test "a user should enter a last name" do
		user = User.new
		assert !user.save
		assert !user.errors[:last_name].empty?
	end

	test "a user should enter a profile name" do
		user = User.new
		assert !user.save
		assert !user.errors[:profile_name].empty?
	end
	
	test "a user should have a unique profile name" do
		user = User.new
		user.profile_name = users(:mathias).profile_name
		assert !user.save
		assert !user.errors[:profile_name].empty?
	end
	
	test "a user should have a profile name without spaces" do
		user = User.new(first_name: 'Mathias', last_name: 'Maehlum', email: 'mathias.ppc@gmail.com')
		user.password = user.password_confirmation = 'asdfasdf'
		user.profile_name = "My Profile With Spaces"
		
		assert !user.save
		assert !user.errors[:profile_name].empty?
		assert user.errors[:profile_name].include?("must be formatted correctly.")
	end	
	
	test "a user can have a correctly formatted profile name" do
		user = User.new(first_name: 'Niko', last_name: 'Fisk', email: 'niaarre2@gmail.com')
		user.password = user.password_confirmation = 'fiskefisken'
		user.profile_name = 'niaarre'
		assert user.valid?
	end	
end