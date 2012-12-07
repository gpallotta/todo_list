# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  done       :boolean          default(FALSE)
#

class Task < ActiveRecord::Base
  attr_accessible :title

  belongs_to :user

  validates_presence_of :user_id, :title

  default_scope order: 'tasks.created_at DESC'

end
