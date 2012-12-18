require 'spec_helper'

describe TasksController do

  let(:user) { FactoryGirl.create(:user) }

  before { sign_in user }

  describe "creating task using ajax" do
    it "increments task count" do
      expect do
        xhr :post, :create, task: { title: 'ajax test title' }
      end.to change(Task, :count).by(1)
    end
    it "responds with success" do
      xhr :post, :create, task: { title: 'ajax test title' }
      response.should be_success
    end
  end
end
