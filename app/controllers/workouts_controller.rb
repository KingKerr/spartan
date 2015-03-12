class WorkoutsController < ApplicationController

  def index
    @workouts = Workout.all
    user = current_user

  end

  def new
    @upper_body_workouts = upper_body
    @lower_body_workouts = lower_body
    @cardio_workouts = cardio

  end

  def upper_body
    @workout = Workout.new
    @upper_body_options = ["Pull Ups", "Bench Press", "Shrugs", "Shoulder Press", "Upright Rows"]
  end

  def lower_body
    @workout = Workout.new
    @lower_body_options = ["Squats", "Deadlifts", "Lunges", "Calf Raises", "Reverse Hypers"]
  end

  def cardio
    @workout = Workout.new
    @cardio_options = ["Sprints", "Walking", "Jog", "Treadmill"]
  end

  def create
    @workouts = Workout.new(workout_params)
    if @workout.save
      redirect_to user_workouts_path(current_user.id)
    else
      format.html { render :new }
      format.json { render json: @user.errors, status: :unprocessable_entity}
    end
  end

  def update
    respond_to do |format|
      if @workout.update(workout_params)
        format.html { redirect_to @workout, notice: 'Workout was successfully updated.'}
        format.json { render :show, status: :ok, location: @workout }
      else
        format.html { render :edit }
        format.json { render json: @workout.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @workout.destroy
    respond_to do |format|
      format.html { redirect_to workouts_url, notice: 'Workout was successfully destroyed.'}
      format.json { head :no_content }
    end
  end

  private

  def set_workout
    @user = User.find(params[:id])
  end

  def workout_params
    params.require(:workout).permit(:type, :name)
  end


end
