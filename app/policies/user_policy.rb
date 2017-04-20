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
        @current_user.admin?    
    end 
    def new? 
        @current_user.admin? || @current_user.counselor? 
    end 
    def create? 
        @current_user.admin? || @current_user.counselor? 
    end 
    def show?
        @current_user.admin? || @current_user == @user
    end 
    def edit?
        @current_user.admin? || @current_user.counselor?
    end 
    def update?
        @current_user.admin?    
    end 
    
    def destroy?
        return false if @current_user == @user
        @current_user.admin?
    end 
end 