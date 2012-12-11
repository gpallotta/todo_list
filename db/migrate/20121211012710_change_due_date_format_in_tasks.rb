class ChangeDueDateFormatInTasks < ActiveRecord::Migration
  def up
    change_column :tasks, :due_date, :string
  end

  def down
    change_column :tasks, :due_date, :string
  end
end
