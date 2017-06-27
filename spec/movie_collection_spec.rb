describe MovieCollection do
  subject(:collection) { described_class.new('spec/movies.txt') }

  describe '#all' do
    its(:all) { is_expected.to be_an(Array).and have_attributes(count: 50).and all be_a Movie }
  end

  describe '#sort_by' do
    subject { collection.sort_by(:length) }
    MovieCollection::FIELDS.each do |field|
      let(:length) { field }
      context "when #{field}"
      it { is_expected.to eq(collection.all.sort_by(&:length)) }
    end
  end

  describe '#filter' do
    subject { collection.filter(movie_filter) }

    context 'when empty filter' do
      let(:movie_filter) { {} }
      it { is_expected.to eq(collection.all) }
    end

    context 'when movie title' do
      let(:movie_filter) { { title: 'The terminator' } }
      it { is_expected.to all have_attributes(title: 'The terminator') }
    end

    context 'when movie year' do
      let(:movie_filter) { { year: 2000 } }
      it { is_expected.to all have_attributes(year: 2000) }
    end

    context 'when movie country' do
      let(:movie_filter) { { country: 'USA' } }
      it { is_expected.to all have_attributes(country: 'USA') }
    end

    context 'when movie genre' do
      let(:movie_filter) { { genre: include('Comedy') } }
      it { is_expected.to all have_attributes(genre: include('Comedy')) }
    end

    context 'when movie director' do
      let(:movie_filter) { { director: 'James Cameron' } }
      it { is_expected.to all have_attributes(director: 'James Cameron') }
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

    context 'when not correct data' do
      let(:movie_filter) { { director: 'Fedor Bondarchuk' } }
      it { is_expected.to all have_attributes(director: 'Fedor Bondarchuk') }
    end
  end

  describe '#stats' do
    subject { collection.stats(movie_stats) }

    shared_examples 'stats' do
      it { is_expected.to be_an(Array) }
    end

    MovieCollection::FIELDS.each do |field|
      context "Movie when #{field}" do
        let(:movie_stats) { field }
        it_should_behave_like 'stats'
      end
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
end
