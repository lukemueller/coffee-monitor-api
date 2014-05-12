require_relative '../../lib/transactions_service'

class TransactionsController < ApplicationController
  def index
    payload = {
      balance: transaction_service.get_balance,
      transactions: transactions_serializer.serialize(transaction_service.get_transactions)
    }

    render json: payload, status: 200
  end

  private

  def transaction_service
    @_transaction_service ||= TransactionsService.new
  end

  def transactions_serializer
    @_transactions_serializer ||= TransactionsSerializer.new
  end
end
