require 'spec_helper'

describe "UserPages" do
  let!(:user) { FactoryGirl.create(:user) }
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

      describe "automatically signs in the new user" do
        before { click_button 'Create account' }
        it { should have_link 'Sign out' }
      end

    end

  end # end for describe signup

  describe "user profile page" do
    before { visit user_path(user) }
    it { should have_content(user.email) }
    it { should have_content(user.name) }
    it { should have_selector('h4', text: "#{user.number_done}") }
    it { should have_link('Edit', href: edit_user_path(user)) }
  end

  describe "editing a user" do
    before { visit edit_user_path(user) }
    let(:new_name) { "New name" }

    describe "with invalid information" do
      before do
        fill_in "user_name", with: new_name
        click_button 'Save changes'
      end

      it "doesn't update the user" do
        user.reload.name.should_not == new_name
      end
      pending "displays error message after attempt" do
        
      end
    end

    describe "with valid information" do
      before do
        fill_in "user_name",  with: new_name 
        fill_in "user_password", with: 'foobar'
        fill_in "user_password_confirmation", with: 'foobar'
        click_button 'Save changes'
      end
      it "updates the user information" do
        user.reload.name.should == new_name
      end
    end
  end


end
