# frozen_string_literal: true

class RewardsController < ApplicationController
  def index
    @rewards = Reward.all
  end

  def show
    @reward = Reward.find(params[:id])
  end

  private

  def reward_params
    params.require(:reward).permit(:title, :description, :price)
  end
end
