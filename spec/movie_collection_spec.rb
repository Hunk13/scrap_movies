describe MovieCollection do
  subject(:collection) { described_class.new('spec/movies.txt') }

  describe '#all' do
    its(:all) { is_expected.to be_an(Array).and have_attributes(count: 50).and all be_a Movie }
  end

  describe '#filter' do
    subject { collection.filter(movie_filter) }

    context 'when empty filter' do
      let(:movie_filter) { {} }
      it { is_expected.to eq(collection.all) }
    end

    context 'when movie title' do
      let(:movie_filter) { { title: 'The Matrix' } }
      it { is_expected.to all have_attributes(title: 'The Matrix') }
      it { is_expected.to_not be_empty }
    end

    context 'when movie year' do
      let(:movie_filter) { { year: 2000 } }
      it { is_expected.to all have_attributes(year: 2000) }
      it { is_expected.to_not be_empty }
    end

    context 'when movie country' do
      let(:movie_filter) { { country: 'USA' } }
      it { is_expected.to all have_attributes(country: 'USA') }
      it { is_expected.to_not be_empty }
    end

    context 'when movie genre' do
      let(:movie_filter) { { genre: 'Comedy' } }
      it { is_expected.to all have_attributes(genre: include('Comedy')) }
      it { is_expected.to_not be_empty }
    end

    context 'when movie director' do
      let(:movie_filter) { { director: 'James Cameron' } }
      it { is_expected.to all have_attributes(director: 'James Cameron') }
      it { is_expected.to_not be_empty }
    end

    context 'when all movie filters' do
      let(:movie_filter) { { actors: 'James Cameron', rating: 8.5,
                             duration: /\d{3}/, genre: 'Action', date: 1984,
                             country: 'USA', title: 'The terminator',
                             year: 2000, director: 'James Cameron' } }
      it { is_expected.to all have_attributes(actors: include('James Cameron'),
                                              rating: 8.5, duration: /\d{3}/,
                                              genre: 'Action', date: 1984,
                                              country: 'USA', title: 'The terminator',
                                              year: 2000, director: 'James Cameron' ) }
    end

    context 'when not correct field' do
      let(:movie_filter) { { composer: 'Enio Moriccone' } }
      it { expect { subject }.to raise_error(NoMethodError) }
    end
  end

  describe '#stats' do
    subject { collection.stats(movie_stats) }

    context 'when filed not exist' do
      let(:movie_stats) { :composer }
      it { expect { subject }.to raise_error(RuntimeError) }
    end

    context 'when filed director' do
      let(:movie_stats) { :director }
      it { is_expected.to be_an(Array).and have_attributes(count: 50) }
    end
  end

  describe '#genre_exists?' do
    subject { collection.genre_exists?(movie_genre) }

    context 'when genre exist' do
      let(:movie_genre) { 'Action' }
      it { is_expected.to be_truthy }
    end

    context 'when genre not exist' do
      let(:movie_genre) { 'Criminalis' }
      it { is_expected.to be_falsey }
    end
  end

  describe 'test Enumerable module' do
    context 'map' do
      subject { collection.map(&:genre) }
      it { is_expected.to be_a Array }
    end

    context 'select' do
      subject { collection.select { |mov| (1968...2000) === mov.year }.first }
      it { is_expected.to be_a ModernMovie }
    end

    context 'reject' do
      subject { collection.reject { |mov| mov.length.even? }.count }
      it { is_expected.to eq(27) }
    end
  end
end
