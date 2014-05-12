require 'spec_helper'

describe TransactionsController do
  describe '#index' do
    let(:serializer_double) { double(TransactionsSerializer) }
    let(:service_double) { double(TransactionsService) }

    before do
      TransactionsSerializer.stub(new: serializer_double)
      TransactionsService.stub(new: service_double)
    end

    it 'should return transactions' do
      serializer_double.stub(serialize: [
        {'date' => '2/1/2014', 'amount' => -8.50},
        {'date' => '1/30/2013', 'amount' => -10.00}
      ])
      service_double.stub(get_balance: 100.00)
      service_double.stub(get_transactions: [])

      get :index

      expect(service_double).to have_received(:get_balance)
      expect(service_double).to have_received(:get_transactions)
      expect(serializer_double).to have_received(:serialize).with([]).once
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['balance']).to eq(100.00)
      expect(JSON.parse(response.body)['transactions']).to eq([
                                                                {'date' => '2/1/2014', 'amount' => -8.50},
                                                                {'date' => '1/30/2013', 'amount' => -10.00}
                                                              ])
    end
  end
end
