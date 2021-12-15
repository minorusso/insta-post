class AddImgToBlogs < ActiveRecord::Migration[6.0]
  def change
    add_column :blogs, :img, :string
  end
end
