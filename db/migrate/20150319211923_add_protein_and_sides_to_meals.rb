class AddProteinAndSidesToMeals < ActiveRecord::Migration
  def change
    add_column :meals, :protein, :string, null: false
    add_column :meals, :sides, :string, null: false
  end
end
