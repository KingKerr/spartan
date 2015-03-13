class AddUpperBodyAndLowerBodyAndCardioToWorkouts < ActiveRecord::Migration
  def change
    add_column :workouts, :upper_body, :string, null: false
    add_column :workouts, :lower_body, :string, null: false
    add_column :workouts, :cardio, :string, null: false
  end
end
