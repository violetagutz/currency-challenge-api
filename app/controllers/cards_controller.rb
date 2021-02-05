class CardsController < ApplicationController
  def create
    card = Card.new(limit: params[:limit])
    if card.save
      render json: { id: card.id, limit: card.limit, error: false }, status: 201
    else
      render json: { error: card.errors.messages }, status: 400
    end
  end
end
