class SimilarRecipesController < ApplicationController

	def index
		@similar_recipes = Recipe.where("recipe_id = ?", "#{params[:q]}")

	    respond_to do |format|
	        format.html
	        format.json {render :json => @categories.map(&:attributes)}
	    end
	end
end
