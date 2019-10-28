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

  test "state isn't changed for :won game" do
    game = Game.init_game() |> Map.put(:game_state, :won)
    assert { ^game, _} = Game.make_move(game, "x")
  end


  test "state isn't changed for :lost game" do
    game = Game.init_game() |> Map.put(:game_state, :lost)
    assert { ^game, _} = Game.make_move(game, "x")
  end


end
