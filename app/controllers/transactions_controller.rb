class TransactionsController < ApplicationController
  # Hooks
  before_action :set_user

  # Shows list of logged in user transactions
  def index
  end

  # Initiate new transfer
  # Accepts sender_id
  def new
    current_user.moneys_out.new
  end

  # Creates transfer
  # Accepts sender_id, mobile or email and amount
  def create
    @transaction = current_user.moneys_out.new(transaction_params)

    # Get recipient_id
    recipient = User.find_by_email_or_mobile(params[:recipient_key])

    # Set transaction attributes
    @transaction.attributes = {
      recipient_id: recipient.id,
      transaction_type: :transfer,
      happened_on: Time.zone.now
    }

    # Attempt to save
    if @transaction.save!
      flash[:notice] = "#{@transaction.code} confirmed. KES #{@transaction.amount} sent to #{@transaction.recipient.name} (#{@transaction.recipient.mobile} on #{@transaction.happened_on}. New balance is #{current_user.balance}."
      redirect_to transactions_path
    else
      flash[:error] = @transaction.errors.full_messages.to_sentence
    end
  end

  # Shows transaction details
  # Accepts transaction id
  def show
    @transaction = Transaction.find(params[:id])
  end

  # Initiate account top up
  # Accepts user_id
  def new_top_up
    current_user.moneys_in.new
  end

  # Credites user account
  # Accepts amount and mobile
  def create_top_up
    @transaction = current_user.moneys_in.new(transaction_params)

    # Set transaction attributes
    @transaction.attributes = {
      sender_id: current_user.id,
      transaction_type: :topup,
      happened_on: Time.zone.now
    }

    if @transaction.save!
      flash[:notice] = "#{@transaction.code} confirmed. KES #{@transaction.amount} added to your account on #{@transaction.happened_on}. New balance is #{current_user.balance}."
      redirect_to transactions_path
    else
      flash[:error] = @transaction.errors.full_messages.to_sentence
    end
  end

  private
  # Callbacks for common setup or constraints between actions
  # Allowed parameters
	def transaction_params
		params.require(:transaction).permit(:amount, :recipient_key)
	end

  # Set logged in user
  def set_user
    @user = current_user
  end
end
