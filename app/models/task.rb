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

class Task < ActiveRecord::Base
  attr_accessible :title, :due_date
  before_destroy :update_number_done

  belongs_to :user

  validates_presence_of :user_id, :title

  default_scope order: 'tasks.created_at DESC'

  protected

  def update_number_done
    @user = User.find(user_id)
    @user.update_column(:number_done, @user.number_done+1)
  end

end
