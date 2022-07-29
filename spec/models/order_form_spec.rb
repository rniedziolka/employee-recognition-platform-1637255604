# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  let!(:employee) { create(:employee) }

  context 'when buying postal reward' do
    it 'returns true when all params are correct' do
      create(:kudo, receiver: employee)
      address = create(:address)
      reward_post = create(:reward, price: 1, delivery_method: 'post')
      params = { address_id: address.id, employee: employee, reward: reward_post.id }
      create_order_form = described_class.new(params)
      expect(create_order_form.save).to be true
    end

    it 'adds new order to db' do
      create(:kudo, receiver: employee)
      address = create(:address)
      reward_post = create(:reward, price: 1, delivery_method: 'post')
      params = { address_id: address.id, employee: employee, reward: reward_post.id }
      orders_count_before = Order.all.count
      create_order_form = described_class.new(params)
      create_order_form.save
      expect(Order.all.count).to eq(orders_count_before + 1)
    end

    it 'when employee has no address in db' do
      create(:kudo, receiver: employee)
      reward_post = create(:reward, price: 1, delivery_method: 'post')
      params = { address_id: nil, employee: employee, reward: reward_post.id }
      create_order_form = described_class.new(params)
      expect(create_order_form.save).to be false
      expect(Address.all.count).to eq(0)
    end

    it 'adds new address in db' do
      create(:kudo, receiver: employee)
      address = create(:address)
      reward_post = create(:reward, price: 1, delivery_method: 'post')
      params = { address_id: address.id, employee: employee, reward: reward_post.id }
      create_order_form = described_class.new(params)
      create_order_form.save
      expect(Address.all.count).to eq(1)
    end

    it 'returns false without address params' do
      create(:kudo, receiver: employee)
      reward_post = create(:reward, price: 1, delivery_method: 'post')
      params = { address_id: nil, employee: employee, reward: reward_post.id }
      create_order_form = described_class.new(params)
      expect(create_order_form.save).to be false
      expect(create_order_form.errors.full_messages.to_s).to include "Street can't be blank"
      expect(create_order_form.errors.full_messages.to_s).to include "Postcode can't be blank"
      expect(create_order_form.errors.full_messages.to_s).to include "City can't be blank"
    end

    it 'returns false when not enough funds' do
      reward_post_price = create(:reward, price: 10, delivery_method: 'post')
      address = create(:address)
      params = { address_id: address.id, employee: employee, reward: reward_post_price.id }
      create_order_form = described_class.new(params)
      expect(create_order_form.save).to be false
      expect(create_order_form.errors.full_messages.to_s).to include 'You have insufficient funds in your account.'
    end
  end

  context 'when buying online reward' do
    it 'returns true when all params are correct' do
      create(:kudo, receiver: employee)
      reward_online = create(:reward, price: 1, delivery_method: 'online')
      params = { employee: employee, reward: reward_online.id }
      create_order_form = described_class.new(params)
      expect(create_order_form.save).to be true
    end

    it 'adds new order to db' do
      create(:kudo, receiver: employee)
      reward_online = create(:reward, price: 1, delivery_method: 'online')
      params = { employee: employee, reward: reward_online.id }
      orders_count_before = Order.all.count
      create_order_form = described_class.new(params)
      create_order_form.save
      expect(Order.all.count).to eq(orders_count_before + 1)
    end

    it 'returns false when not enough funds' do
      reward_online_price = create(:reward, price: 10, delivery_method: 'online')
      params = { employee: employee, reward: reward_online_price.id }
      create_order_form = described_class.new(params)
      expect(create_order_form.save).to be false
      expect(create_order_form.errors.full_messages.to_s).to include 'You have insufficient funds in your account.'
    end
  end
end
