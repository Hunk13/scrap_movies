describe ScrapMovies::Movie do
  subject(:collection) { ScrapMovies::MovieCollection.new('spec/movies.txt') }

  subject(:movie) {
     ScrapMovies::ModernMovie.new(['http://imdb.com/title/tt0111161/?ref_=chttp_tt_1',
                                   'The Shawshank Redemption',
                                   '1994',
                                   'USA',
                                   '1994-10-14',
                                   'Crime,Drama',
                                   '142 min',
                                   '9.3',
                                   'Frank Darabont',
                                   'Tim Robbins,Morgan Freeman,Bob Gunton'], collection)
                  }

  describe '#genre?' do
    subject { movie.genre?(genre) }

    context 'when genre present' do
      let(:genre) { 'Crime' }
      it { is_expected.to be_truthy }
    end

    context 'when genre not present' do
      let(:genre) { 'Action' }
      it { is_expected.to be_falsey }
    end

    context 'when genre non exist' do
      let(:genre) { 'Criminalis' }
      it { expect { subject }.to raise_error(RuntimeError, "Genre 'Criminalis' not found in movies genres") }
    end
  end

  describe '#actors' do
    context 'when first actors must be Array' do
      its(:actors) { is_expected.to be_an(Array).and have_attributes(count: 3) }
    end
  end

  describe '#movie_price' do
    context 'when first movie price' do
      it { expect(movie.movie_price).to eq(Money.new(300)) }
    end
  end
end
