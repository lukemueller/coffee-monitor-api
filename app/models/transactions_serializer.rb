class TransactionsSerializer
  def serialize(transactions)
    transactions.map do |transaction|
      {
        date: transaction.date.strftime('%-m/%-d/%Y'),
        amount: transaction.amount
      }
    end
  end
end
