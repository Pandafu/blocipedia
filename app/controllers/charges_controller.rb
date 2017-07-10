class ChargesController < ApplicationController
before_action :set_downgrade_wiki, only: :destroy

  def create
  # Creates a Stripe Customer object, for associating
  # with the charge
  @amount = 1500

  customer = Stripe::Customer.create(
    email: current_user.email,
    card: params[:stripeToken]
  )

  current_user.update_attribute(:role, 'premium')

   #Where the real magic happens
  charge = Stripe::Charge.create(
    customer: customer.id, # Note -- this is NOT the user_id in your app
    amount: @amount,
    description: "BigMoney Membership - #{current_user.email}",
    currency: 'usd'
  )

  flash[:notice] = "Thanks for all the money, #{current_user.email}! You are now a #{current_user.role} member!"
  redirect_to wikis_path # or wherever

  # Stripe will send back CardErrors, with friendly messages
  # when something goes wrong.
  # This `rescue block` catches and displays those errors.
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.email}",
      amount: @amount
    }
  end

  def destroy
    current_user.update_attribute(:role, 'standard')


    if current_user.role == 'standard'
      flash[:notice] = "You now have #{current_user.role}. You can always upgrade again, anytime."
      redirect_to wikis_path
    else
      flash[:error] = "Error"
      redirect_to edit_user_registration_path
    end
  end

  private

  def set_downgrade_wiki
    current_user.wikis.each do |wiki|
      wiki.update_attribute(:private, false)
    end
  end
end
