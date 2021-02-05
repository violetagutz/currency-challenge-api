class TransactionsController < ApplicationController

  def create
    card = Card.find_by(id: params[:card_id])

    if !card
      render json: { error: "Card with this ID does not exist." }, status: 400
      return
    end

    transaction = Transaction.new(amount: params[:amount],
                                 card_id: params[:card_id])
    total_usage = card.sum_of_transactions
    balance = card.calculate_balance

    if card.limit < total_usage
      render json: { card_id: card.id, error: "Insufficient Balance on Card",
                     available_balance: balance }, status: 400
    elsif transaction.save
      render json: { id: transaction.id, total_usage: total_usage,
                     error: false }, status: 201
    else
      render json: { error: transaction.errors.full_messages }, status: 400
    end
  end
end
