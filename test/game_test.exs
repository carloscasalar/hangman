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
    for state <- [:won, :lost] do
      game = Game.init_game()
             |> Map.put(:game_state, state)
      assert {^game, _} = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is not already used" do
    game = Game.init_game()
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "second occurrence of letter is already used" do
    game = Game.init_game()
    {game, _tally} = Game.make_move(game, "x")
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.init_game("waffle")
    {game, _tally} = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a guessed word is a won game" do
    game = Game.init_game("waffle")
    {game, _tally} = Game.make_move(game, "w")
    {game, _tally} = Game.make_move(game, "a")
    {game, _tally} = Game.make_move(game, "f")
    {game, _tally} = Game.make_move(game, "l")
    {game, _tally} = Game.make_move(game, "e")
    assert game.game_state == :won
    assert game.turns_left == 7
  end

  test "bad guess is recognized" do
    game = Game.init_game("wok")
    {game, _tally} = Game.make_move(game, "a")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "lost game is recognized" do
    game = Game.init_game("wok")
    {game, _tally} = Game.make_move(game, "a")
    {game, _tally} = Game.make_move(game, "b")
    {game, _tally} = Game.make_move(game, "c")
    {game, _tally} = Game.make_move(game, "d")
    {game, _tally} = Game.make_move(game, "e")
    {game, _tally} = Game.make_move(game, "f")
    {game, _tally} = Game.make_move(game, "g")
    assert game.game_state == :lost
    assert game.turns_left == 0
  end
end
