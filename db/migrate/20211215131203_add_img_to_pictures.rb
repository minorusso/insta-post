class AddImgToPictures < ActiveRecord::Migration[6.0]
  def change
    add_column :pictures, :img, :string
  end
end
