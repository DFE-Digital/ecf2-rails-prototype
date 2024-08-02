class PineapplesController < ApplicationController
  def show
    render json: { controller: "🍍" }
  end
end
