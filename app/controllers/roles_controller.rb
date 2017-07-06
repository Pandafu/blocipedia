class RolesController < ApplicationController


  def upgrade(user)
    user.update_attributes!(role: 'premium')
  end

  def downgrade(user)
    user.update_attributes!(role: 'standard')
  end
end
