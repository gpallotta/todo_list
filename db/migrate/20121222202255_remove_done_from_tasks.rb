class RemoveDoneFromTasks < ActiveRecord::Migration
  def up
    remove_column :tasks, :done
  end

  def down
    add_column :tasks, :done, :boolean, :default => false
  end
end
