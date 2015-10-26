class RecipesController < ApplicationController
  
  def index 
    #@recipes = Recipe.all.sort_by{|likes| likes.thumbs_up_total}.reverse
    @recipes = Recipe.paginate(:page => params[:page], per_page: 4)
  end
  
  def show
    @recipe = Recipe.find(params[:id])
    
  end
  
  def new 
    @recipe = Recipe.new
  end
  
  def create
    #binding.pry # you can se what is in params
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = Chef.find(1)

    
    if @recipe.save
      flash[:success] = "Your recipe was created succesfully"
      redirect_to recipes_path
    else 
      render :new
    end
  end

  def edit 
    @recipe =Recipe.find(params[:id])

  end

  def update
    @recipe =Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe was updated succesfully"
      redirect_to recipe_path(@recipe)
    else 
      render :edit
    end 
  end

  def like
    @recipe = Recipe.find(params[:id])
    like = Like.create(like: params[:like], chef: Chef.first, recipe: @recipe)
    if like.valid?
      flash[:success] = "Your like was added succesfully"
      redirect_to :back
    else 
      flash[:danger] = "Your can only like/dislike once"
      redirect_to :back
    end
  end

  
  private 
    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture)
    end
  
end