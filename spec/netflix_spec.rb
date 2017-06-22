describe Netflix do
  subject(:collection) { described_class.new('movies.txt') }

  describe '#show' do
    before { collection.pay(money) }
    subject { collection.show(title) }

    context 'when enough money' do
      let(:money) { 10 }
      let(:title) { { title: 'The Terminator' } }
      it {
        expect { subject }
          .to output(/^Now showing: The Terminator \d{2}:\d{2}:\d{2} - \d{2}:\d{2}:\d{2}/i)
          .to_stdout
          .and change(collection, :money).by(-3)
      }
    end

    context 'when not enough money' do
      let(:money) { 1 }
      let(:title) { { title: 'The Terminator' } }
      it {
        expect { subject }
          .to raise_error(RuntimeError, 'Not enough money. This movie cost 3. Your balance 1')
          .and change(collection, :money).by(0)
      }
    end

    context 'when film not found' do
      let(:money) { 10 }
      let(:title) { { title: 'The Terminators' } }
      it {
        expect { subject }
          .to raise_error(RuntimeError, 'Film Not Found')
          .and change(collection, :money).by(0)
      }
    end
  end

  describe '#how_much?' do
    subject { collection.how_much?(movie_name) }

    context 'when film found' do
      let(:movie_name) { 'The Terminator' }
      it { expect(subject).to be_a_kind_of(Numeric) }
    end

    context 'when film not found' do
      let(:movie_name) { 'The Terminators' }
      it { expect { subject }
        .to raise_error(ArgumentError, "Movie 'The Terminators' not found")
      }
    end
  end

  describe '#pay' do
    context 'when correct pay' do
      it { expect { subject.pay(10) }.to change(collection, :money).by(10) }
    end

    context 'when incorrect pay' do
      it { expect { subject.pay(-5) }
        .to raise_error(ArgumentError, 'Value -5 not correct')
      }
    end
  end
end
