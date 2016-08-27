class TransactionsController < ApplicationController
  # Hooks
  before_action :set_user

  # Shows list of logged in user transactions.
  # Transaction types: money received, money sent and top ups.
  # Input(s): logged in user
  def index
  end

  # Displays new money transfer page.
  # Input(s): logged in user
  def new
    @transaction = current_user.moneys_out.new
  end

  # Creates money transfer transaction.
  # Inputs: logged in user, recipient (mobile or email), amount.
  def create
    @transaction = current_user.moneys_out.new(transaction_params)

    # Get recipient_id
    recipient = User.find_by_email_or_mobile(@transaction.recipient_key)
    if recipient
      # Set transaction attributes
      @transaction.attributes = {
        recipient_id: recipient.id,
        transaction_type: :transfer,
        happened_on: Time.zone.now
      }

      if @transaction.valid?
        # Save transaction
        if @transaction.save
          # Send notification to recipient
          # SendEmailJob.set(wait: 2.minutes).perform_later(@transaction)
          TransactionMailer.received_money_email(@transaction).deliver

          # Return to list of transactions
          flash[:notice] = "<span class='text-uppercase'>#{@transaction.code}</span> confirmed. KES #{@transaction.amount} sent to #{@transaction.recipient.name}."
          redirect_to transactions_path
        else
          flash[:error] = @transaction.errors.full_messages.to_sentence
        end
      else
        flash[:error] = @transaction.errors.full_messages.to_sentence
        render new_transaction_path
      end
    else
      flash[:error] = "WPESA couldn't find that recipient. Verify the mobile or email before trying again."
      render new_transaction_path
    end
  end

  # Shows transaction details.
  # Input(s): Transaction ID
  def show
    @transaction = Transaction.find(params[:id])
  end

  # Displays account top up page.
  # Input(s): Logged in user.
  def new_top_up
    @transaction = current_user.moneys_in.new
  end

  # Tops up logged in user's account.
  # Input(s): logged in user, amount.
  def create_top_up
    @transaction = current_user.moneys_in.new(transaction_params)

    # Set transaction attributes
    @transaction.attributes = {
      sender_id: current_user.id,
      transaction_type: :topup,
      happened_on: Time.zone.now
    }

    if @transaction.save!
      flash[:notice] = "<span class='text-uppercase'>#{@transaction.code}</span> confirmed. KES #{@transaction.amount} added to your account on."
      redirect_to transactions_path
    else
      flash[:error] = @transaction.errors.full_messages.to_sentence
    end
  end

  private
    # Callbacks for common setup or constraints between actions
  
    # Restricts parameters allowed for transactions (amount, recipient).
  	def transaction_params
  		params.require(:transaction).permit(:amount, :recipient_key)
  	end

    # Assigns logged in user to an accessible instance variable.
    def set_user
      @user = current_user
    end
end
