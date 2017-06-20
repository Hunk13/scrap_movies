describe MovieCollection do
  subject { described_class.new('movies.txt') }

  describe '#all_records' do
    it 'All collection count' do
      expect(subject.all.count).to eq(250)
    end

    it 'All collection must be Array' do
      expect(subject.all).to be_an(Array)
    end
  end

  describe '#sort_by' do
    it 'Sorting by length must be Array' do
      expect(subject.sort_by(:length)).to be_an(Array)
    end
  end

  describe '#filter' do
    it 'Testing filters must be Array' do
      expect(subject.filter(director: 'Frank Darabont',
                            year: 1940..2000,
                            genre: 'Drama',
                            actors: 'Tim Robbins',
                            title: 'The Shawshank Redemption')).to be_an(Array)
    end
  end

  describe '#stats' do
    it 'Statistic by genre must be Array' do
      expect(subject.stats(:genre)).to be_an(Array)
    end

    it 'Statistic puts by genre must be Hash' do
      expect(subject.stats_puts(subject.stats(:genre))).to be_an(Hash)
    end
  end
end
