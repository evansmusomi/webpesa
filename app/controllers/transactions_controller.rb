class TransactionsController < ApplicationController

  # Generate list of transactions and calculate balance
  # Accepts user_id
  def index
    @user = current_user
  end

  # Initiate new transfer
  # Accepts sender_id
  def new

  end

  # Creates transfer
  # Accepts sender_id, mobile or email and amount
  def create

  end

  # Shows transaction details
  # Accepts transaction id
  def show

  end

  # Initiate account top up
  # Accepts user_id
  def new_top_up

  end

  # Credites user account
  # Accepts amount and mobile
  def create_top_up

  end

  private

  # Allowed parameters
  def transaction_params
    # Callbacks for common setup or constraints between actions
		def transaction_params
			params.require(:transaction).permit(:amount, :recipient_mobile, :recipient_email)
		end
  end
end
