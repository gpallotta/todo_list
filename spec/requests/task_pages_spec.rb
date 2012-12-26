require 'spec_helper'

describe "TaskPages" do
 
  let!(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  subject { page }

  describe "home page" do
    let!(:task) { FactoryGirl.create(:task, user: user) }
    let!(:deleted_task) { FactoryGirl.create(:task, user: user) }
    before do
      visit tasks_path
      click_link deleted_task.title
    end

    it "displays tasks" do   
      should have_content(task.title)
    end

    it "doesn't display tasks which are deleted" do
      should_not have_content(deleted_task.title)
    end

    it "displays count of tasks" do
      should have_selector("div.task-stats.header", text: "#{user.tasks.count}")
      #hard coded because 'can't convert fixnum into string' if var used
    end

    describe "creating a task" do
      before do
        fill_in 'task_title', with: 'spec task'
        click_button 'Post'
      end
      it "displays the new task" do
        should have_content('spec task')
      end
      it "increments the task count" do
        should have_selector('div.task-stats.header', text: "2")
      end

      describe "then deleting the task" do
        let!(:old_token) { user.remember_token }
        let!(:old_num_completed) { user.number_done }
        it "deletes the task instance" do
          expect { click_link 'spec task' }.to change(Task, :count).by(-1)
        end

        it "updates the front page information" do
          click_link 'spec task'
          should_not have_content("spec task")
          should have_selector('div.task-stats.header', text: '1')
        end

        it "increments the number done on user page" do
          visit user_path(user)
          should have_content(1)
        end

        it "does not alter the remember token" do
          user.remember_token.should == old_token
        end
      end
    end
  end # end for taskpages

end
