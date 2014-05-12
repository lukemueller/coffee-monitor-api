require 'spec_helper'

describe TransactionsSerializer do
  let(:serializer) { TransactionsSerializer.new }
  describe '#serialize' do
    it 'should serialize transactions' do
      first_transaction = Transaction.new(date: Date.new(2014, 5, 12), amount: -6.75)
      second_transaction = Transaction.new(date: Date.new(2014, 5, 8), amount: 100)
      expected_serialization = [
        {date: '5/12/2014', amount: -6.75},
        {date: '5/8/2014', amount: 100.00}
      ]

      expect(serializer.serialize([first_transaction, second_transaction])).to eq(expected_serialization)
    end
  end
end
