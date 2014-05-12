require 'nokogiri'

class TransactionsService
  TRANSACTIONS_URL = 'https://wwws.givex.com/public/balance/history.py?380611856+_LANGUAGE_:en+webinfo_id:602316637xfb304006e8ac5135eed2d4772471b76fx6'

  def initialize
    @document = load_document
  end

  def get_balance
    _, amount = /(\$)(\d+\.\d\d)/.match(balance_row.content).captures
    amount.to_f
  end

  def get_transactions
    transaction_rows.map do |table_row|
      content = table_row.content
      year, month, day = /(\d\d\d\d)-(\d\d)-(\d\d)/.match(content).captures
      amount_match = /-?\d+\.\d\d/.match(content)

      Transaction.new(date: Date.new(year.to_i, month.to_i, day.to_i), amount: amount_match[0].to_f)
    end
  end

  private

  def load_document
    response = Net::HTTP.get(URI(TRANSACTIONS_URL))
    Nokogiri::HTML::Document.parse(response)
  end

  def transaction_table
    @_transaction_table ||= @document.xpath('//table//table')[1]
  end

  def balance_row
    transaction_table.children.last
  end

  def transaction_rows
    transaction_table.children[1...-1]
  end
end
