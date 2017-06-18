describe Movie do
  subject { MovieCollection.new('movies.txt') }

  it 'Genre exist? (Correct genre) must be True' do
    expect(subject.all.first.genre?('Crime')).to be_truthy
  end

  it 'Genre exist? (Correct genre but not include) must be False' do
    expect(subject.all.first.genre?('Action')).to be_falsey
  end

  it 'Genre exist? (Not correct genre, not exist) must give RuntimeError' do
    expect { subject.all.first.genre?('Criminalis') }.to raise_error(RuntimeError, "Genre 'Criminalis' not found in movies genres")
  end

  it 'First actors must be Array' do
    expect(subject.all.first.actors).to be_an(Array)
  end

  it 'First movie price' do
    expect(subject.all.first.movie_price).to eq(3)
  end
end
