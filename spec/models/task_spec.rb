# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  due_date   :string(255)
#

require 'spec_helper'

describe Task do
  let(:user) { FactoryGirl.create(:user) }
  before { @task = user.tasks.build(title: 'Test task') }

  subject { @task }

  it { should respond_to(:title) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:done) }
  it { should respond_to(:due_date) }
  its(:user) { should == user }

  it { should_not be_done }
  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Task.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
  
  describe "when user_id is not present" do
    before { @task.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank title" do
    before { @task.title = " " }
    it { should_not be_valid }
  end
end
