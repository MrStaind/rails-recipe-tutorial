class IngredientsController < ApplicationController
	def new
		@ing = Ingredient.new
	end

	def create
		@ing = Ingredient.new(ingredient_params)

		if @ing.save
			flash[:success] = "Ingredient was create successfuly"
			redirect_to recipes_path
		else
			render "new"
		end				
	end

	private

	def ingredient_params
		params.require(:ingredient).permit(:name)
	end
end