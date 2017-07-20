module ScrapMovie
  describe ScrapMovies::CashDesk do
    let(:test_class) { Class.new { include ScrapMovies::CashDesk } }
    let(:dummy) { test_class.new }

    describe '#take' do
      subject { dummy.take(inkass) }
      before(:each) { dummy.pay_money(100) }

      context 'set amount of money to zero if it is called by bank' do
        let(:inkass) { 'Bank' }
        it { expect { subject }.to change { dummy.cash }.from('$100.00').to('$0.00') }
      end

      context 'raises error in other case' do
        let(:inkass) { 'Gop-Stop' }
        it { expect { subject }.to raise_error("The police'll be here soon!!!") }
      end
    end

    describe '#cash' do
      subject { dummy.cash }
      context 'returns zero money' do
        it { is_expected.to eq('$0.00') }
      end
    end

    describe '#pay_money' do
      subject { dummy.pay_money(amount) }

      context 'negative amount cashbox' do
        let(:amount) { -50 }
        it { expect { subject }.to raise_error('Amount should be positive') }
      end

      context 'moves sum of money to cashbox' do
        let(:amount) { 50 }
        it { expect { subject }.to change { dummy.cash }.from('$0.00').to('$50.00') }
      end
    end
  end
end
