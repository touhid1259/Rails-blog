class AddProfilePicToProfile < ActiveRecord::Migration
  def up
    add_column :profiles, :profile_pic, :string
  end

  def down
    remove_column :profiles, :profile_pic
  end
end
