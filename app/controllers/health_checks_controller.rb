class HealthChecksController < ApplicationController
  def show
    render json: { status: 'ok', time: Time.now }, status: :ok
  end
end
