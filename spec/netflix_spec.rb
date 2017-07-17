describe ScrapMovies::Netflix do
  subject(:netflix) { described_class.new('spec/movies.txt') }
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
                                                 'Tim Robbins,Morgan Freeman,Bob Gunton'], netflix)
                 }

  describe '#show' do
    before { netflix.pay(money) }
    subject { netflix.show(title) }
    let(:title) { { title: 'The Shawshank Redemption' } }

    context 'when enough money' do
      let(:money) { 10 }
      it {
        @time_now = Time.parse('18:22:22')
        allow(Time).to receive(:now).and_return(@time_now)
        allow(netflix).to receive(:select_movie).and_return(movie)
        expect { subject }
          .to output('Now showing: The Shawshank Redemption 18:22:22 - 20:44:22')
          .to_stdout
          .and change(netflix, :money).by(-Money.new(300))
      }
    end

    context 'when not enough money' do
      let(:money) { 1 }
      it {
        expect { subject }
          .to raise_error(RuntimeError, 'Not enough money. This movie cost 3.00. Your balance 1.00')
          .and not_change(netflix, :money).from(Money.new(100))
      }
    end

    context 'when film not found' do
      let(:money) { 10 }
      let(:title) { { title: 'The Terminator' } }
      it {
        expect { subject }
          .to raise_error(RuntimeError, 'Film Not Found')
          .and not_change(netflix, :money).from(Money.new(1000))
      }
    end
  end

  describe '#how_much?' do
    subject { netflix.how_much?(movie_name) }

    context 'when film found' do
      let(:movie_name) { '12 Angry Men' }
      it { expect(subject).to eq("$1.50") }
    end

    context 'when film not found' do
      let(:movie_name) { 'The Terminator' }
      it { expect { subject }
        .to raise_error(ArgumentError, "Movie 'The Terminator' not found")
      }
    end
  end

  describe '#pay' do
    subject { netflix.pay(money) }

    context 'when correct pay' do
      let(:money) { 10 }
      it { expect { subject }.to change(netflix, :money).by(Money.new(1000)) }
    end

    context 'when incorrect pay' do
      let(:money) { -10 }
      it { expect { subject }
        .to raise_error(ArgumentError, 'Value -10 not correct')
      }
    end
  end
end
