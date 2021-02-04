class CardsController < ApplicationController
  def create
    card = Card.new
    if card.save
      render json: { id: card.id, error: false }, status: 201
    end
  end
end
