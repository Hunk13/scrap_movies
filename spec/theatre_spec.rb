describe Theatre do
  subject { described_class.new('movies.txt') }

  it 'Testing show movie' do
    expect { subject.show('Morning') }.to output(/^«[a-z].*[a-z]\s\d{2}:\d{2}:\d{2} - \d{2}:\d{2}:\d{2}»/i).to_stdout
  end

  it 'Testing not exist period' do
    expect { subject.show('Night') }.to raise_error(NoMethodError)
  end

  it 'Testing when show movie' do
    expect(subject.when?('Gone with the Wind')).to eq(%w(Morning Evening))
  end
end
