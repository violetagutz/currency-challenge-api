class CardsController < ApplicationController

  def create
    card = Card.new(limit: params[:limit])
    if card.save
      render json: { card_id: card.id, limit: card.limit, error: false }, status: 201
    else
      render json: { error: "Limit must be grater than 0" }, status: 400
    end
  end

  # check for the existence of card in the database and return findings
  def get_card_if_exists
    card = Card.first

    if card
      card_attributes = card.attributes
      card_attributes[:total_usage] = card.sum_of_charges
    else
      card_attributes = card
    end
    render json: { card: card_attributes }, status: 201
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
