class MealsController < ApplicationController

  def index
    @meals = Meal.all
    user = current_user
  end

  def new
    @protein_meals = protein
    @sides_meals = sides

  def protein
    @meal = Meal.new
    @protein_options = ["Chicken", "Grass-fed Beef", "Shrimp", "Fish", "Beans", "Pork"]
  end

  def sides
    @meal = Meal.new
    @side_options = ["Brown Rice", "Salad", "Pasta", "Potatoes"]
  end

  def create
    @meals = Meal.new(meal_params)
    if @meal.save
      redirect_to user_meals_path(current_user.id)
    else
      format.html { render :new }
      format.json { render json: @user.errors, status: :unprocessable_entity}
    end
  end

  def update
    respond_to do |format|
      if @meal.update(meal_params)
        format.html { redirect_to @meal, notice: 'Meal was successfully updated.'}
        format.json { render :show, status: :ok, location: @meal }
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
    @meal = User.find(params[:id])
  end

  def meal_params
    params.require(:meal).permit(:type, :name)
  end

end
