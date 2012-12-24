# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  remember_token  :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  number_done     :integer          default(0)
#

require 'spec_helper'

describe User do
  before { @user = User.new(name: 'Greg', email: 'test@test.com',
                              password: 'foobar', password_confirmation: 'foobar') }
  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }

  it { should be_valid }

  describe "with no name" do
    before { @user.name = "" }
    it { should_not be_valid }
  end

  describe "with no email" do
    before { @user.email = "" }
    it { should_not be_valid }
  end

  describe "when email is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    it { should_not be_valid }
  end

  describe "with no password" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "with password not matching confirmation" do
    before { @user.password_confirmation = "alsdkj" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation  = nil }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("nope") }
      it { should_not == user_for_invalid_password }
      it { user_for_invalid_password.should be_false }
    end
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" }
    it { should_not be_valid }
  end

  describe "email address with mixed case" do
    let(:mixed_email) { 'TeSt@TEst.cOM' }
    it "is saved as all lowercase" do
      @user.email = mixed_email 
      @user.save
      @user.reload.email.should == mixed_email.downcase
    end
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "task associations" do
    before { @user.save }
    let!(:older_task) do
      FactoryGirl.create(:task, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_task) do
      FactoryGirl.create(:task, user: @user, created_at: 1.hour.ago)
    end

    it "has the tasks in the right order" do
      @user.tasks.should == [newer_task, older_task ]
    end

    it "destroys associated tasks" do
      tasks = @user.tasks
      @user.destroy
      tasks.each do |task|
        Task.find_by_id(task.id).should be_nil
      end
    end
  end

end
