class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :type
      t.string :name

      t.timestamps null: false
    end
  end
end
