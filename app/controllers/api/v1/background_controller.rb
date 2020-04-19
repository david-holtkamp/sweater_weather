class Api::V1::BackgroundController < ApplicationController

  def show
    render json: BackgroundSerializer.new(Background.new(params[:location]))
  end
end
