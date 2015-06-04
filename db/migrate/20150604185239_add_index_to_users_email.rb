class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
  		#on the user model, the email colum will be saved with an index. It must be unique
  	    add_index :users, :email, unique: true
  end
end
