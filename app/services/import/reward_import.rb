# frozen_string_literal: true

require 'csv'

module Import
  class RewardImport
    def initialize(data)
      @data = data
    end

    def self.import(file)
      ActiveRecord::Base.transaction do
        CSV.foreach(file.path, headers: true) do |row|
          reward_hash = row.to_hash
          if reward_hash['slug'].present?
            reward = Reward.find_or_initialize_by(slug: reward_hash['slug'])
            reward.slug = reward_hash['title'].parameterize
            reward.title = reward_hash['title']
            reward.description = reward_hash['description']
            reward.price = reward_hash['price'].to_f
            reward.delivery_method = reward_hash['delivery_method']
            reward.save!
          else
            Reward.create! row.to_hash
          end
        end
      rescue ActiveRecord::RecordNotFound, CSV::MalformedCSVError
        false
      end
    end
  end
end
