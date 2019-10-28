defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "init_game returns structure" do
    game = Game.init_game()

    is_letter = ~r/[a-z]/

    assert game.turns_left == 7
    assert game.game_sate == :initializing
    assert length(game.letters) > 0

    assert Enum.all? game.letters, fn letter -> letter =~ is_letter end
  end

end
