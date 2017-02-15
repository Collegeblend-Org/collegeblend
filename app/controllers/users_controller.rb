class UsersController < ApplicationController
    before_filter :authenticate_user!
    def index 
        @users = User.all
        authorize User
    end 
    
    def show 
        @user = User.find(params[:id]) 
    end 
    
    def destroy 
        user = User.find(parms[:id])
        user.destroy 
        redirect_to users_path, :notic => "User deleted"
    end 
end
