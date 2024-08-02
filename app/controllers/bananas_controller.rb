class BananasController < ApplicationController
  def show
    render json: { controller: "🍌" }
  end
end
