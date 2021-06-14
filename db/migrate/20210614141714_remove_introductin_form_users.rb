class RemoveIntroductinFormUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :introductin, :text
    
  end
end
