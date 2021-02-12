class TransactionsController < ApplicationController

  def create
    card = Card.find_by(id: params[:card_id])

    if !params[:amount] || params[:amount].to_i < 1
      render json: {error: "Amount must be greater than 0"}, status: 400

    elsif !card
      render json: { error: "Card with this ID does not exist" }, status: 400

    elsif params[:amount].to_i > card.available_balance
      render json: { error: "Insuficient balance on the Card",
                     available_balance: card.available_balance }, status: 400

    else
      transaction = Transaction.new(amount: params[:amount],
                                   card_id: params[:card_id])

      if transaction.amount > card.average_transactions_amount &&
          card.average_transactions_amount > 0
        render json: { error: "Sorry transaction cannot be completed." },
                       status: 400
      elsif transaction.save
        render json: { id: transaction.id, total_usage: card.sum_of_charges,
                       error: false }, status: 201
      else
        render json: { error: transaction.errors.full_messages }, status: 400
      end
    end
  end
end
