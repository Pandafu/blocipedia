class Wiki < ActiveRecord::Base
  #before_action :authenticate_user!
  belongs_to :user
  #has_many dependent: :destroy
end
