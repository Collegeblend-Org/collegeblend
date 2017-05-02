class UsersController < ApplicationController
    before_filter :authenticate_user!
    # make sure you're setting authorization for each action
    after_action :verify_authorized
    def index 
        @users = User.all
        authorize User
    end 
    
    def show 
        @user = User.find(params[:id]) 
        authorize @user
        @new_user = check_if_new_user
    end 
    
    def destroy 
        user = User.find(params[:id])
        authorize user
        user.destroy 
        redirect_to users_path, :notice => "User deleted"
    end 
    
    def update
        @user = User.find(params[:id]) 
        authorize @user
        
        if @user.update_attributes(secure_params)
            redirect_to users_path, :success => 'User updated'
        else 
            redirect_to users_path, :alert  => 'Unable to Update User'
        end
    end 
    
    private
        
        def secure_params
            params.require(:user).permit(:role)
        end
        
        def check_if_new_user
            if @user.points_total == 0
                @user.add_points(50)
                @new_user = true
            else 
                @new_user = false
            end
        end
end
