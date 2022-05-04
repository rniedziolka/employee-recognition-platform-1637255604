# frozen_string_literal: true

class RewardsController < ApplicationController
  REWARDS_PER_PAGE = 10
  def index
    page = params[:page].to_i || 0
    number_of_pages = (Reward.count.to_f / REWARDS_PER_PAGE).ceil
    rewards = Reward.limit(REWARDS_PER_PAGE).offset(page * REWARDS_PER_PAGE)
    if params[:page].to_i <= number_of_pages - 1
      render 'index', locals: { page: page, number_of_pages: number_of_pages, rewards: rewards }
    else
      redirect_to rewards_path, notice: "Enter page in range 1 to #{number_of_pages}."
    end
  end

  def show
    render :show, locals: { reward: reward }
  end

  private

  def reward
    @reward ||= Reward.find(params[:id])
  end
end
