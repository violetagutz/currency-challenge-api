# Preview all emails at http://localhost:3000/rails/mailers/transaction_mailer
class TransactionMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/transaction_mailer/confirm_flag_transaction
  def confirm_flag_transaction
    TransactionMailer.confirm_flag_transaction
  end

end
