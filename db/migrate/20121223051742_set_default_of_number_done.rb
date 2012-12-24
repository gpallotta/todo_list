class SetDefaultOfNumberDone < ActiveRecord::Migration
  def up
    change_column :users, :number_done, :integer, :default => 0
  end

  def down
    change_column :users, :number_done, :integer
  end
end
