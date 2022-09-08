# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateOrderService do
  context 'when buying postal reward' do
    it 'returns true when all params are correct and adds order to db' do
      employee = create(:employee)
      create(:kudo, receiver: employee) # add funds
      reward_post = create(:reward, price: 1, delivery_method: 'post', available_items: 1)
      params = { address: attributes_for(:address), reward_id: reward_post.id }
      before_orders_conut = Order.all.count
      create_order_service = described_class.new(params: params, employee: employee)

      expect(create_order_service.call).to be true
      expect(Order.all.count).to eq before_orders_conut + 1
    end

    it 'adds new order to db' do
      employee = create(:employee)
      create(:kudo, receiver: employee) # add funds
      reward_post = create(:reward, price: 1, delivery_method: 'post', available_items: 1)
      params = { address: attributes_for(:address), reward_id: reward_post.id }
      create_order_service = described_class.new(params: params, employee: employee)

      expect { create_order_service.call }.to change { Order.all.count }.by(1)
    end

    it 'adds new address to db when employee doesnt have address' do
      employee = create(:employee)
      create(:kudo, receiver: employee) # add funds
      reward_post = create(:reward, price: 1, delivery_method: 'post', available_items: 1)
      params = { address: attributes_for(:address), reward_id: reward_post.id }
      create_order_service = described_class.new(params: params, employee: employee)

      expect { create_order_service.call }.to change { Address.all.count }.by(1)
    end

    it 'changes address when employee have existing address' do
      employee = create(:employee)
      create(:kudo, receiver: employee) # add funds
      create(:address, employee: employee) # add address to employee
      reward_post = create(:reward, price: 1, delivery_method: 'post', available_items: 1)
      params = { address: attributes_for(:address), reward_id: reward_post.id }
      create_order_service = described_class.new(params: params, employee: employee)

      expect { create_order_service.call }.not_to change { Address.all.count }
      expect(Address.last.postcode).to include params[:address][:postcode]
    end

    it 'returns false without address params' do
      employee = create(:employee)
      create(:kudo, receiver: employee) # add funds
      reward_post = create(:reward, price: 1, delivery_method: 'post', available_items: 1)
      params = { reward_id: reward_post.id }
      create_order_service = described_class.new(params: params, employee: employee)

      expect(create_order_service.call).to be false
      expect(create_order_service.errors.to_s).to include "Street can't be blank"
      expect(create_order_service.errors.to_s).to include "Postcode can't be blank"
      expect(create_order_service.errors.to_s).to include "City can't be blank"
    end

    it 'returns false when not enough funds' do
      employee = create(:employee)
      reward_post = create(:reward, price: 1, delivery_method: 'post', available_items: 1)
      params = { address: attributes_for(:address), reward_id: reward_post.id }
      create_order_service = described_class.new(params: params, employee: employee)

      expect(create_order_service.call).to be false
      expect(create_order_service.errors.to_s).to include 'You have insufficient funds'
    end

    it 'returns false when not enough items in stock' do
      employee = create(:employee)
      create(:kudo, receiver: employee) # add funds
      reward_post = create(:reward, price: 1, delivery_method: 'post', available_items: 0)
      params = { address: attributes_for(:address), reward_id: reward_post.id }
      create_order_service = described_class.new(params: params, employee: employee)

      expect(create_order_service.call).to be false
      expect(create_order_service.errors.to_s).to include 'Not enough items in stock'
    end
  end

  context 'when buying online reward' do
    it 'returns true when all params are correct' do
      employee = create(:employee)
      create(:kudo, receiver: employee) # add funds
      reward_online = create(:reward, price: 1, delivery_method: 'online')
      create(:online_code, reward: reward_online) # add online_code to reward
      params = { employee: employee, reward_id: reward_online.id }
      create_order_service = described_class.new(params: params, employee: employee)

      expect(create_order_service.call).to be true
    end

    it 'adds new order to db' do
      employee = create(:employee)
      create(:kudo, receiver: employee) # add funds
      reward_online = create(:reward, price: 1, delivery_method: 'online')
      create(:online_code, reward: reward_online) # add online_code to reward
      params = { employee: employee, reward_id: reward_online.id }
      create_order_service = described_class.new(params: params, employee: employee)

      expect { create_order_service.call }.to change { Order.all.count }.by(1)
    end

    it 'delivers online_code via email after purchase' do
      employee = create(:employee)
      create(:kudo, receiver: employee) # add funds
      reward_online = create(:reward, price: 1, delivery_method: 'online')
      online_code = create(:online_code, reward: reward_online)
      params = { employee: employee, reward_id: reward_online.id }
      create_order_service = described_class.new(params: params, employee: employee)

      expect { create_order_service.call }.to change { ActionMailer::Base.deliveries.count }.by(1)
      expect(ActionMailer::Base.deliveries.last).to eq OrderDeliveryMailer.with(order: create_order_service.order,
                                                                                code: online_code.code).online_code_delivery_email
    end

    it 'returns false when there is no available online_codes to buy' do
      employee = create(:employee)
      create(:kudo, receiver: employee) # add funds
      reward_online = create(:reward, price: 1, delivery_method: 'online')
      params = { employee: employee, reward_id: reward_online.id }
      create_order_service = described_class.new(params: params, employee: employee)

      expect(create_order_service.call).to be false # there were no online_codes present
      expect(create_order_service.errors.to_s).to include 'Not enough items in stock'
    end

    it 'returns false when emoployee doesnt have funds for reward' do
      employee = create(:employee)
      reward_online_price = create(:reward, price: 1, delivery_method: 'online')
      create(:online_code, reward: reward_online_price)
      params = { address: attributes_for(:address), reward_id: reward_online_price.id }
      create_order_service = described_class.new(params: params, employee: employee)

      expect(create_order_service.call).to be false
      expect(create_order_service.errors.to_s).to include 'You have insufficient funds'
    end
  end
end
