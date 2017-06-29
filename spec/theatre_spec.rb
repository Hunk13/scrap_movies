describe Theatre do
  subject(:theatre) { described_class.new('spec/movies.txt') }

  describe '#show' do
    subject { theatre.show(time) }

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
    subject { theatre.when?(movie_name) }

    context 'when show movie in Evening' do
      let(:movie_name) { 'The Godfather' }
      it { expect(subject).to eq(['Evening']) }
    end

    context 'when show movie in Afternoon' do
      let(:movie_name) { 'Star Wars: Episode IV - A New Hope' }
      it { expect(subject).to eq(['Afternoon']) }
    end

    context 'when show movie not found' do
      let(:movie_name) { 'Star Wars: Episode IX - This is the End' }
      it { expect { subject }.to raise_error(ArgumentError, "Movie 'Star Wars: Episode IX - This is the End' not found") }
    end
  end
end
