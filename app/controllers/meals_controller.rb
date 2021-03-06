class MealsController < ApplicationController


  def index
    @meals = Meal.all
    user_id = current_user.id
  end

  def new
    @meal = Meal.new
    @protein_options = ["Chicken", "Grass-fed Beef", "Shrimp", "Fish", "Beans", "Turkey"]
    @side_options = ["Brown Rice", "Salad", "Pasta", "Potatoes"]
  end

  def create
    @meals = Meal.new(meal_params)
    if @meals.save
      redirect_to user_meals_path(current_user.id)
    else
      format.html { render :new }
      format.json { render json: @user.errors, status: :unprocessable_entity}
    end
  end

  def update
    respond_to do |format|
      if @meals.update(meal_params)
        format.html { redirect_to @meal, notice: 'Meal was successfully updated.'}
        format.json { render :show, status: :ok, location: @meals }
      else
        format.html { render :edit }
        format.json { render json: @meal.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @meal.destroy
    respond_to do |format|
      format.html { redirect_to meals_url, notice: 'Meal was successfully destroyed.'}
      format.json { head :no_content }
    end
  end

  private

  def set_meal
    @meal = Meal.find(params[:id])
  end

  def meal_params
    params.require(:meal).permit(:protein, :sides)
  end

end
