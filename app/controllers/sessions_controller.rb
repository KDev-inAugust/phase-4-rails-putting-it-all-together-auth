class SessionsController < ApplicationController
    def create
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
        session[:user_id] = user.id
        render json: { id:user.id, username:user.username, image_url:user.image_url, bio:user.bio }, status: :created
        else
        render json: { errors: ["user auth error"] }, status: :unauthorized
        end
    end

    def destroy
        user = User.find_by(id: session[:user_id])
        id = session[:user_id]
        if user
        session.delete :user_id
        head :no_content
        else
        render json: { errors: ["no logged in user"] }, status: :unauthorized
        end
    end

end

