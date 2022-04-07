class AddUsernameToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :username, :string
  end
end
