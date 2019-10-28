defmodule Hangman.Game do

  defstruct(
    turns_left: 7,
    game_sate: :initializing
  )

  def new_game() do
    %Hangman.Game{}
  end

end