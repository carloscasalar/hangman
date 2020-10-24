# CHANGELOG

## 2.0.0 2020-10-24
* Modify Hangman API:
  * `new_game`: now it start a new game in the supervisor tree and returns the game pid.
  * `tally` and `make_move`: it accepts now a game_pid as a parameter instead of a game instance.
* Add a GenServer implementation.
* Add an application implementation with a dynamic supervisor so 
we can spawn games with supervisor. Example:
```elixir
iex(1)> Hangman.new_game()
#PID<0.165.0>

iex(2)> game1 = Hangman.new_game()
#PID<0.167.0>

iex(3)> game2 = Hangman.new_game()
#PID<0.169.0>
        
iex(4)> Hangman.tally(game1)
%{
  game_state: :initializing,
  letters: ["_", "_", "_", "_", "_", "_"],
  turns_left: 7,
  used_letters: []
}

iex(5)> Hangman.tally(game2)
%{
  game_state: :initializing,
  letters: ["_", "_", "_", "_", "_", "_", "_", "_", "_"],
  turns_left: 7,
  used_letters: []
}

iex(6)> Hangman.make_move(game2, "a")
%{
  game_state: :good_guess,
  letters: ["_", "_", "_", "_", "_", "a", "_", "_", "_"],
  turns_left: 7,
  used_letters: ["a"]
}

iex(7)> Hangman.make_move(game1, "e")
%{
  game_state: :good_guess,
  letters: ["_", "_", "_", "_", "_", "e"],
  turns_left: 7,
  used_letters: ["e"]
}
```
This will lead to a tree like this:
```mermaid
graph TD
  A[<0.159.0>] --> B(<0.160.0>)
  B --> C[fa:fa-tv Elixir.Hangman.Supervisor]
  C --> D[fa:fa-gamepad <0.165.0>]
  C --> E[fa:fa-gamepad <0.167.0>]
  C --> F[fa:fa-gamepad <0.169.0>]
		
```

## 1.1.0 2019-12-24
* Game struct has now the used letters

## 1.0.0 2019-11-11
* The base hangman game engine
