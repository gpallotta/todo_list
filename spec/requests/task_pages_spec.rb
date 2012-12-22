require 'spec_helper'

describe "TaskPages" do
 
  let!(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  subject { page }

  describe "home page" do
    let!(:task) { FactoryGirl.create(:task, user: user) }
    let!(:done_task) { FactoryGirl.create(:done, user: user) }
    before { visit tasks_path }

    it "displays tasks which are not done" do   
      should have_content(task.title)
    end
    it "doesn't display tasks which are done" do
      should_not have_content(done_task.title)
    end
    it "displays count of active tasks" do
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

      describe "then marking tasks as done" do
        before { click_link 'spec task' }

        it "removes task from the display page" do
          should_not have_content("spec task")
        end
        it "decrements the task count on front page" do
          should have_selector('div.task-stats.header', text: "1")
        end
      end
    end
  end # end for taskpages

end
