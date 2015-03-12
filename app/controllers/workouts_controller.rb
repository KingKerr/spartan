class WorkoutsController < ApplicationController

  def index
    @workouts = Workout.all
    user = current_user
  end

  def upper_body
    x =["Pull Ups", "Bench Press", "Shrugs", "Shoulder Press", "Upright Rows"]

  end

  def lower_body
    x = ["Squats", "Deadlifts", "Lunges", "Calf Raises", "Reverse Hypers"]
  end

  def cardio
    x = ["Sprints", "Walking", "Jog", "Treadmill"]
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
