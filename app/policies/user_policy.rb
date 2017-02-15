class UserPolicy 
    # always takes user and model 
    attr_reader :current_user, :model
    
    # initialize 
    def initialize(current_user, model)
        @current_user = current_user
        @user = model 
    end 
    
    # is the current user an admin? 
    # if so it can go to index and see index 
    # else it is access denied
    def index?  
        @current_user.student?    
    end 
end 