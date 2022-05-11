# frozen_string_literal: true

class RewardsController < ApplicationController
  REWARDS_PER_PAGE = 10
  def index
    page = params[:page].to_i || 0
    number_of_pages = (RewardSearch.new(params).results.count.to_f / REWARDS_PER_PAGE).ceil
    rewards = RewardSearch.new(params).results.limit(REWARDS_PER_PAGE).offset(page * REWARDS_PER_PAGE).includes(:categories, :category_rewards)
    categories = Category.all
    if params[:page].to_i <= number_of_pages - 1
      render :index, locals: { page: page, number_of_pages: number_of_pages, rewards: rewards, categories: categories }
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
