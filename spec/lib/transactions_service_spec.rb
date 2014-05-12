require 'spec_helper'
require 'nokogiri'

describe TransactionsService do
  let(:service) { TransactionsService.new }

  before do
    Artifice.activate_with(FakeGivexServer)
  end

  after do
    Artifice.deactivate
  end

  describe '#get_balance' do
    it 'returns the balance from the page' do
      expect(service.get_balance).to eq(67.75)
    end
  end

  describe '#get_transactions' do
    it 'returns an array of transactions' do
      actual_transactions = service.get_transactions

      expect(actual_transactions.length).to eq(3)
      expect(actual_transactions[0].date).to eq(Date.new(2014, 5, 9))
      expect(actual_transactions[0].amount).to eq(-2.75)
      expect(actual_transactions[1].date).to eq(Date.new(2014, 5, 7))
      expect(actual_transactions[1].amount).to eq(-6.50)
      expect(actual_transactions[2].date).to eq(Date.new(2014, 5, 1))
      expect(actual_transactions[2].amount).to eq(100.00)
    end
  end
end
