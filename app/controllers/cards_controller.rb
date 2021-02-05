class CardsController < ApplicationController
  def create
    card = Card.new(limit: params[:limit])
    if card.save
      render json: { card: card, error: false }, status: 201
    else
      render json: { error: card.errors.messages }, status: 400
    end
  end

  # check for the existence of card in the database and return findings
  def get_card_if_exist
    card = Card.first
    if card
      render json: { card: card }, status: 200
    end
  end

  def available_balance
    card = Card.find_by(id: params[:id])
    balance = card.calculate_balance
    render json: { id: card.id, available_balance: balance }
  end
end
