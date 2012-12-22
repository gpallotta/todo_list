require 'spec_helper'

describe "TaskPages" do
 
  let!(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  subject { page }

  describe "home page" do
    let!(:task) { FactoryGirl.create(:task, user: user) }
    before { visit tasks_path }

    it "displays tasks" do   
      should have_content(task.title)
    end

    pending "doesn't display tasks which are deleted" do
    end

    it "displays count of tasks" do
      should have_selector("div.task-stats.header", text: "1")
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
        it "deletes the task instance" do
          expect { click_link 'spec task' }.to change(Task, :count).by(-1)
          should_not have_content("spec task")
          should have_selector('div.task-stats.header', text: '1')
        end
      end
    end
  end # end for taskpages

end
