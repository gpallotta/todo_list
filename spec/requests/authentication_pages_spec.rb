require 'spec_helper'

describe "AuthenticationPages" do
  
  subject { page }

	describe "signin" do
		before { visit signin_path }

    describe "with invalid information" do
		  before { click_button "Sign in" }
			it { should have_content('Incorrect') }
      it { should_not have_link('Profile') }
      it { should_not have_link('Sign out', href: signout_path) }
		end

    describe "with valid information" do
		  let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

			it { should have_link('Sign out', href: signout_path) }
			it { should have_link('Profile', href: user_path(user)) }
			it { should_not have_link('Sign in', href: signin_path) }

      describe "followed by signout" do
			  before { click_link "Sign out" }
				it { should have_link('Sign in') }
			end
		end

	end # end for describe signin

end # end for describe authentication
