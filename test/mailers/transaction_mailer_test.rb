require "test_helper"

class TransactionMailerTest < ActionMailer::TestCase
  test "confirm_flag_transaction" do
    mail = TransactionMailer.confirm_flag_transaction
    assert_equal "Confirm flag transaction", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
