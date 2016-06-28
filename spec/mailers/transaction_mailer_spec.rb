require "rails_helper"

RSpec.describe TransactionMailer, type: :mailer do
  
  describe "received_money_email" do
  	include ApplicationHelper

  	let(:transaction){ FactoryGirl.create :transaction }
   	before(:each) do
  		ActionMailer::Base.deliveries = []
  		TransactionMailer.received_money_email(transaction).deliver_now	
  	end

  	after(:each) do
  		ActionMailer::Base.deliveries.clear
  	end

  	it "sends email" do
  		expect(ActionMailer::Base.deliveries.count).to eq (1)
  	end

  	it  "renders subject" do
  		expect(ActionMailer::Base.deliveries.first.subject).to include("You're KES #{transaction.amount} richer on WPESA")
  	end

  	it "renders correct recipient email" do
  		expect(ActionMailer::Base.deliveries.first.to).to eq([transaction.recipient.email])
  	end

  	it "renders correct sender email" do
  		expect(ActionMailer::Base.deliveries.first.from).to eq(['notifications@webpesa.com'])
  	end

  	it "contains user's name" do
  		expect(ActionMailer::Base.deliveries.first.body.encoded).to include("#{transaction.recipient.name}")
  	end

  	it "contains company website" do
  		expect(ActionMailer::Base.deliveries.first.body.encoded).to match("http://lvh.me:3000")
  	end
  end
end
