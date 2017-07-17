describe ScrapMovies::Theatre do
  subject(:theatre) { described_class.new('spec/movies.txt') }

  describe '#show' do
    subject { theatre.show(time) }

    context 'when exist period' do
      let(:time) { 'Morning' }
      let(:time_now) { Time.parse('18:22:22') }
      let(:movie) {
                    ScrapMovies::ModernMovie.new(['http://imdb.com/title/tt0111161/?ref_=chttp_tt_1',
                                                  'The Shawshank Redemption',
                                                  '1994',
                                                  'USA',
                                                  '1994-10-14',
                                                  'Crime,Drama',
                                                  '142 min',
                                                  '9.3',
                                                  'Frank Darabont',
                                                  'Tim Robbins,Morgan Freeman,Bob Gunton'], theatre)
                  }

      it {
        allow(Time).to receive(:now).and_return(time_now)
        allow(theatre).to receive(:select_movie).and_return(movie)
        expect { subject }
          .to output('Now showing: The Shawshank Redemption 18:22:22 - 20:44:22')
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
