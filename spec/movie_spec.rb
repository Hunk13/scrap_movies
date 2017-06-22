describe Movie do
  subject(:collection) { MovieCollection.new('movies.txt') }
  subject(:movie) { collection.all.first }

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
    subject { movie }

    it 'First actors must be Array' do
      expect(subject.actors).to be_an(Array)
    end
  end

  describe '#movie_price' do
    subject { movie }

    it 'First movie price' do
      expect(subject.movie_price).to eq(3)
    end
  end
end
