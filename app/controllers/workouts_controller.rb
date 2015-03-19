class WorkoutsController < ApplicationController

  def index
    @workouts = Workout.all
    user_id = current_user.id
  end

  def new
    @workout = Workout.new
    @upper_body_options = ["Pull Ups", "Bench Press", "Shrugs", "Shoulder Press", "Upright Rows"]
    @lower_body_options = ["Squats", "Deadlifts", "Lunges", "Calf Raises", "Reverse Hypers"]
    @cardio_options = ["Sprints", "Walking", "Jog", "Treadmill", "Bike Ride"]
  end

  def create
    @workouts = Workout.new(workout_params)
    if @workouts.save
      redirect_to user_workouts_path(current_user.id)
    else
      format.html { render :new }
      format.json { render json: @user.errors, status: :unprocessable_entity}
    end
  end

  def update
    respond_to do |format|
      if @workouts.update(workout_params)
        format.html { redirect_to @workouts, notice: 'Workout was successfully updated.'}
        format.json { render :show, status: :ok, location: @workouts }
      else
        format.html { render :edit }
        format.json { render json: @workouts.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @workouts.destroy
    respond_to do |format|
      format.html { redirect_to workouts_url, notice: 'Workout was successfully destroyed.'}
      format.json { head :no_content }
    end
  end

  private

  def set_workout
   @workout = Workout.find(params[:id])
  end

  def workout_params
    params.require(:workout).permit(:cardio, :upper_body, :lower_body)
  end


end
