defmodule Hangman.Game do

  defstruct(
    turns_left: 7,
    game_sate: :initializing,
    letters: [],
  )

  def init_game() do
    %Hangman.Game{
      letters: Dictionary.random_word
               |> String.codepoints
    }
  end

  def make_move(game = %{game_state: sate}, _guess) when sate in [:won, :lost] do
    {game, tally(game)}
  end

  def tally(game) do
    123
  end

end