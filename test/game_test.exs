defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "init_game returns structure" do
    game = Game.init_game()

    is_letter = ~r/[a-z]/

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0

    assert Enum.all? game.letters, fn letter -> letter =~ is_letter end
  end

  test "state isn't changed for :won or :lost game" do
    for state <- [ :won, :lost ] do
      game = Game.init_game() |> Map.put(:game_state, state)
      assert { ^game, _} = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is not already used" do
    game = Game.init_game()
    { game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end
  
  test "second occurrence of letter is already used" do
    game = Game.init_game()
    { game, _tally} = Game.make_move(game, "x")
    { game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

end
