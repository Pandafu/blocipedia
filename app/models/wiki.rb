class Wiki < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true
  has_many :collaborators
  has_many :users, through: :collaborators

  #Add helper wiki model methods for adding/removing/checking collaborators
  def add_collaborator(collaborator)
    collaborators.create(user: collaborator)
  end

  def remove_collaborator(collaborator)
    collaborators.find_by(user: collaborator).destroy
  end

  def check_collaborator(collaborator)
    collaborators.where(user: collaborator).exists?
  end
end
