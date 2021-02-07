class TransactionsController < ApplicationController

  def create
    card = Card.find_by(id: params[:card_id])

    if !params[:amount] || params[:amount].to_i < 1
      render json: {error: "Amount must be greater than 0"}, status: 400

    elsif !card
      render json: { error: "Card with this ID does not exist" }, status: 400

    elsif params[:amount].to_i > card.available_balance
      render json: { error: "Insuficient balance on the account" }, status: 400

    else
      transaction = Transaction.new(amount: params[:amount],
                                   card_id: params[:card_id])

      if transaction.save
        render json: { id: transaction.id, amount: transaction.amount,
                       created_at: transaction.created_at,
                       total_usage: card.sum_of_charges,
                       error: false }, status: 201
      else
        render json: { error: transaction.errors.full_messages }, status: 400
      end
    end
  end
end
