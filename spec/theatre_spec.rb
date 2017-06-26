describe Theatre do
  subject(:collection) { described_class.new('spec/movies.txt') }

  describe '#show' do
    subject { collection.show(time) }

    context 'when exist period' do
      let(:time) { 'Morning' }
      it { expect { subject }
        .to output(/^«[a-z].*[a-z]\s\d{2}:\d{2}:\d{2} - \d{2}:\d{2}:\d{2}»/i)
        .to_stdout
      }
    end

    context 'when not exist period' do
      let(:time) { 'Night' }
      it { expect { subject }.to raise_error(RuntimeError, 'Films not showing in Night') }
    end
  end

  describe '#when?' do
    subject { collection.when?(movie_name) }

    context 'when show movie' do
      let(:movie_name) { 'The Godfather' }
      it { expect(subject).to eq(['Evening']) }
    end
  end
end
