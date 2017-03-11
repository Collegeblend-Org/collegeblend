class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    include Honor
 
 
    enum role: [:student, :counselor, :admin]
        after_initialize :set_default_role, :if => :new_record?
 
     def set_default_role
        self.role ||= :student
     end 
     
    def points_to_money
        money = self.points_total * 0.2
        if money > 1000
            return 1000
        else
            return '%.2f' % money
        end
    end
     
    def money_earned_out_of_money_possible
        money = self.points_total * 0.2
        money_possible = 1000
        if money > money_possible
            return 100
        else
            perc_earned_to_possible = (money / money_possible) * 100
            return '%.2f' % perc_earned_to_possible
        end
    end
  
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable
         
    validates :first_name, :middle_initial, :last_name, :birthdate, presence: true
    
    has_many :articles
end
