defmodule Hangman.Game do

  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: [],
    used: MapSet.new(),
  )

  def init_game(initial_word) do
    %Hangman.Game{
      letters: initial_word
               |> String.codepoints
    }
  end

  def init_game() do
    Dictionary.random_word
    |> init_game
  end

  def make_move(game = %{game_state: sate}, _guess) when sate in [:won, :lost] do
    {game, tally(game)}
  end

  def make_move(game, guess) do
    game = accept_move(game, guess, MapSet.member?(game.used, guess))
    {game, tally(game)}
  end

  def tally(game) do
    %{
      game_state: game.game_state,
      turns_left: game.turns_left,
      letters: game.letters
               |> reveal_guessed(game.used)
    }
  end

  def accept_move(game, _guess, _already_guessed = true) do
    Map.put(game, :game_state, :already_used)
  end

  def accept_move(game, guess, _not_yet_guessed = false) do
    Map.put(game, :used, MapSet.put(game.used, guess))
    |> score_guess(Enum.member?(game.letters, guess))
  end

  def score_guess(game, _good_guess = true) do
    new_state = MapSet.new(game.letters)
                |> MapSet.subset?(game.used)
                |> maybe_won

    Map.put(game, :game_state, new_state)
  end

  def score_guess(game = %{turns_left: 1}, _not_good_guess) do
    %{
      game |
      game_state: :lost,
      turns_left: 0
    }
  end

  def score_guess(game = %{turns_left: turns_left}, _not_good_guess) do
    %{
      game |
      game_state: :bad_guess,
      turns_left: turns_left - 1
    }
  end

  def reveal_guessed(letters, used) do
    letters
    |> Enum.map(fn letter -> reveal_letter(letter, MapSet.member?(used, letter)) end)
  end

  def reveal_letter(letter, _in_word = true), do: letter
  def reveal_letter(_letter, _not_in_word), do: "_"

  def maybe_won(true), do: :won
  def maybe_won(_), do: :good_guess
end