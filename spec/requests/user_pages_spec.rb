require 'spec_helper'

describe "UserPages" do
  let(:user) { FactoryGirl.create(:user) } 
  subject { page }

  describe "signup" do
    before { visit signup_path }

    describe "with invalid information" do
      it "doesn't create a user" do
        expect { click_button 'Create account' }.not_to change(User, :count)
      end
    end
    describe "with valid information" do
      before do
        fill_in "user_name", with: 'Example User'
        fill_in "user_email", with: 'example@example.com'
        fill_in "user_password", with: ' foobar'
        fill_in 'user_password_confirmation', with: ' foobar'
      end
      it "creates a user" do
        expect { click_button 'Create account' }.to change(User, :count).by(1)
      end
      describe "after creating user" do
        before { click_button 'Create account' }
        it { should have_link 'Sign out' }
      end
    end
  end # end for describe signup

  describe "editing a user" do
    let!(:edited_user) { FactoryGirl.create(:user) }
    before do
      sign_in edited_user
      visit edit_user_path(edited_user)
    end
  end

end
