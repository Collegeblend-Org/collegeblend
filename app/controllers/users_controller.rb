class UsersController < ApplicationController
    def index 
        @users = User.all 
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
