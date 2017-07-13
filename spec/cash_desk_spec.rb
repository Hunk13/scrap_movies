module ScrapMovie
  describe CashDesk do
    let(:test_class) { Class.new { include CashDesk } }
    let(:dummy) { test_class.new }

    describe '#take' do
      subject { dummy.take(inkass) }
      before(:each) { dummy.pay_money(100) }

      context 'set amount of money to zero if it is called by bank' do
        let(:inkass) { 'Bank' }
        it { expect { subject }.to change { dummy.cash }.from(100).to(0) }
        it { is_expected.to eq(0) }
      end

      context 'raises error in other case' do
        let(:inkass) { 'Gop-Stop' }
        it { expect { subject }.to raise_error("The police'll be here soon!!!") }
      end
    end

    describe '#cash' do
      subject { dummy.cash }
      it 'returns zero money' do
        is_expected.to eq(0)
      end
    end

    describe '#pay_money' do
      subject { dummy.pay_money(50) }

      it 'moves sum of money to cashbox' do
        expect { subject }.to change { dummy.cash }.from(0).to(50)
      end
    end
  end
end
