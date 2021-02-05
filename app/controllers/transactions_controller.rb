class TransactionsController < ApplicationController
  def create
    transaction = Transaction.new(amount: params[:amount],
                                 card_id: params[:card_id])
    if transaction.save
      render json: { id: transaction.id, error: false }, status: 201
    else
      render json: { error: transaction.errors.messages }, status: 400
    end
  end
end
