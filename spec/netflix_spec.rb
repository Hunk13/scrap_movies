describe Netflix do
  subject(:netflix) { described_class.new('spec/movies.txt') }

  describe '#show' do
    before { netflix.pay(money) }
    subject { netflix.show(title) }
    let(:title) { { title: '12 Angry Men' } }

    context 'when enough money' do
      let(:money) { 10 }
      it {
        expect { subject }
          .to output(/^Now showing: 12 Angry Men \d{2}:\d{2}:\d{2} - \d{2}:\d{2}:\d{2}/i)
          .to_stdout
          .and change(netflix, :money).by(-1.5)
      }
    end

    context 'when not enough money' do
      let(:money) { 1 }
      it {
        expect { subject }
          .to raise_error(RuntimeError, 'Not enough money. This movie cost 1.5. Your balance 1')
          .and not_change(netflix, :money).from(1)
      }
    end

    context 'when film not found' do
      let(:money) { 10 }
      let(:title) { { title: 'The Terminator' } }
      it {
        expect { subject }
          .to raise_error(RuntimeError, 'Film Not Found')
          .and not_change(netflix, :money).from(10)
      }
    end
  end

  describe '#how_much?' do
    subject { netflix.how_much?(movie_name) }

    context 'when film found' do
      let(:movie_name) { '12 Angry Men' }
      it { expect(subject).to eq(1.5) }
    end

    context 'when film not found' do
      let(:movie_name) { 'The Terminator' }
      it { expect { subject }
        .to raise_error(ArgumentError, "Movie 'The Terminator' not found")
      }
    end
  end

  describe '#pay' do
    context 'when correct pay' do
      it { expect { subject.pay(10) }.to change(netflix, :money).by(10) }
    end

    context 'when incorrect pay' do
      it { expect { subject.pay(-5) }
        .to raise_error(ArgumentError, 'Value -5 not correct')
      }
    end
  end
end
