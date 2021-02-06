class CardsController < ApplicationController

  def create
    card = Card.new(limit: params[:limit])
    if card.save
      render json: { card_id: card.id, limit: card.limit, error: false }, status: 201
    else
      render json: { error: card.errors.full_messages }, status: 400
    end
  end

  # check for the existence of card in the database and return findings
  def get_card_if_exists
    card = Card.first
    render json: { card: card }, status: 200
  end

  def available_balance
    card = Card.find_by(id: params[:id])
    render json: { id: card.id, available_balance: card.available_balance }
  end
end
