# frozen_string_literal: true

module Admin
  class RewardsController < AdminController
    def index
      @rewards = Reward.all
    end

    def show
      @reward = Reward.find(params[:id])
    end

    def new
      @reward = Reward.new
    end

    def edit
      @reward = Reward.find(params[:id])
    end

    def create
      @reward = Reward.new(reward_params)
      if @reward.save
        redirect_to admin_rewards_path(@reward), notice: 'Reward was successfully created.'
      else
        render :new
      end
    end

    def update
      @reward = Reward.find(params[:id])
      if @reward.update(reward_params)
        redirect_to admin_rewards_path(@reward), notice: 'Reward was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @reward = Reward.find(params[:id])
      @reward.destroy
      redirect_to admin_rewards_url, notice: 'Reward was successfully destroyed.'
    end

    private

    def reward_params
      params.require(:reward).permit(:title, :description, :price)
    end
  end
end
