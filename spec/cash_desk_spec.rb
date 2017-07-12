module ScrapMovie
  describe CashDesk do
    let(:test_class) { Class.new { include CashDesk } }
    let(:dummy) { test_class.new }

    describe '#cash' do
      it 'returns sum all money in cash desk'
    end

    describe '#take' do
      it 'when inkass OK'
      it 'when inkass Error, call in Police'
    end

    describe '#cash' do
      subject { dummy.cash }
      it 'returns zero money' do
        is_expected.to eq(0)
      end
    end
  end
end
