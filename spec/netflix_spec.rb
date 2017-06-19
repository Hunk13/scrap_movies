describe Netflix do
  subject { described_class.new('movies.txt') }

  it 'Testing pay' do
    expect(subject.pay(10)).to be_a_kind_of(Numeric)
  end

  it 'How much?' do
    expect(subject.how_much?('The Terminator')).to be_a_kind_of(Numeric)
  end

  it 'When enough money' do
    subject.pay(10)
    expect { subject.show(title: 'The Terminator') }.to output(/^Now showing: The Terminator \d{2}:\d{2}:\d{2} - \d{2}:\d{2}:\d{2}/i).to_stdout
    expect(subject.money).to eq(7)
  end

  it 'Film not found' do
    subject.pay(10)
    expect { subject.show(title: 'The Terminators') }.to raise_error(NoMethodError)
  end
end
