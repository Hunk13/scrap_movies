class CashDeskTest
  include CashDesk
end

describe CashDesk do
  let(:dummy) { CashDeskTest.new }

  describe '#cash' do
    it 'returns sum all money in cash desk'
  end
end
