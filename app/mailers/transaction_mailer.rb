class TransactionMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.transaction_mailer.confirm_flag_transaction.subject
  #
  def confirm_flag_transaction
    @greeting = "Hi"
    @confirmation_token = params[:confirmation_token]
    @amount = params[:amount]

    mail to: ENV['MAIL_TO'], subject: "Confirm purchase outside of US"
  end
end
