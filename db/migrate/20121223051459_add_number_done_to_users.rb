class AddNumberDoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :number_done, :integer
  end
end
