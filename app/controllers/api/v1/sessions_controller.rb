class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      login(user)
    else
      failed
    end
  end

  private

    def login(user)
      render json: UserSerializer.new(user), status: 200
    end

    def failed
      render json: { failed: 'Bad credentials' }, status: 401
    end
end
