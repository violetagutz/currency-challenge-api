class CardsController < ApplicationController

  def create

    card = Card.new(limit: params[:limit])

    if card.save
      render json: { card_id: card.id, limit: card.limit, error: false },
                     status: 201
    else
      render json: { error: "Limit must be greater or equal to $100
                     and less than $1,000,000" }, status: 400
    end
  end

  def get_card_if_exists
    card = Card.first
    info = card.attributes.merge({total_usage: card.sum_of_charges}) if card
    render json: { card: card ? info : nil }, status: 200
  end

  def available_balance
    card = Card.find_by(id: params[:id])
    render json: { id: card.id, available_balance: card.available_balance }
  end

  def delete_card
    Card.destroy_all
    render json: { deleted: true }, status: 200
  end
end
