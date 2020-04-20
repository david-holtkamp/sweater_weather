class Api::V1::AntipodeController < ApplicationController

  def show
    render json: AntipodeSerializer.new(AntipodeFacade.new(params[:location]))
  end
end
