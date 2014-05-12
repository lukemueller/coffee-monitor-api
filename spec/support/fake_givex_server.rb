class FakeGivexServer
  def self.call(env)
    [200, {}, File.open('spec/support/givex_transactions_response.html', 'rb').read]
  end
end
