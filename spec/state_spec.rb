RSpec.describe "State" do

  describe "State Class" do

    before :each do
      @state = State.new
    end

    describe "#initialize" do

      it "inital lives equals 7" do
        expect(@state.total_lives).to eql 7
      end

      it "correct_guesses array intialized as empty" do
        expect(@state.correct_guesses.length).to eql 0
      end

      it "incorrect_guesses array intialized as empty" do
        expect(@state.incorrect_guesses.length).to eql 0
      end

      it "word_display array intialized as empty" do
        expect(@state.word_display.length).to eql 0
      end

    end

    describe ".player_progress" do

      it "array with: _ for unguessed, letter for guessed" do
        @state.correct_guesses = %w[h g m]
        expect(@state.player_progress("hangman")).to eql %w[h _ _ g m _ _]
      end

    end

    describe ".total_lives" do

      it "lives_remaining = 4 when incorrect_guesses.length = 3" do
        @state.incorrect_guesses = %w[c d e]
        expect(@state.lives_remaining).to eql 4
      end

    end

    describe ".letters_remaining" do

      it "returns 2 when word_display == [a _ _]" do
        @state.word_display = %w[a _ _]
        expect(@state.letters_remaining).to eql 2
      end

    end

    describe ".update_guesses" do

      it "adds guesses to correct_gueses when correct" do
        @state.correct_guesses = []
        @state.update_guesses(true, "h")
        expect(@state.correct_guesses).to eql ["h"]
      end

      it "adds guesses to incorrect_gueses when incorrect" do
        @state.incorrect_guesses = []
        @state.update_guesses(false, "q")
        expect(@state.incorrect_guesses).to eql ["q"]
      end

    end

  end
end
