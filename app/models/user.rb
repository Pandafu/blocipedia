class User < ActiveRecord::Base

    enum role: [:standard, :premium, :admin]
    
    after_initialize :set_default_role

    def set_default_role
      self.role ||= :standard
    end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :wikis
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
