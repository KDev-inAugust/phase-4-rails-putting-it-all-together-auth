class RecipesController < ApplicationController
    before_action :authorize

    def index
        recipes=Recipe.all
        render json: recipes, status: :created
    end

    def create
        recipe=Recipe.create(user_id: session[:user_id], title:params[:title], instructions:params[:instructions], minutes_to_complete:params[:minutes_to_complete])
        if recipe.valid?
            render json: recipe, status: :created
        else
            render json: { errors: ["include all recipie parameters"] }, status: :unprocessable_entity
        end
    end
    
    private

    def authorize
        return render json: { errors: ["User Not Authorized To View This Asset"] }, status: :unauthorized unless session.include? :user_id
    end

    def recepie_params
        params.permit(:title, :instructions, :minutes_to_complete )
    end

end
