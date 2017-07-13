module ScrapMovie
  describe CashDesk do
    let(:test_class) { Class.new { include CashDesk } }
    let(:dummy) { test_class.new }

    describe '#take' do
      before(:each) { dummy.pay_money(100) }

      it 'set amount of money to zero if it is called by bank' do
        expect { dummy.take('Bank') }.to change { dummy.cash }.from(100).to(0)
        expect(dummy.take('Bank')).to eq(0)
      end

      it 'raises error in other case' do
        expect { dummy.take('Gop-Stop') }.to raise_error("The police'll be here soon!!!")
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
