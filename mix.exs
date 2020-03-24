defmodule Hangman.MixProject do
  use Mix.Project

  def project do
    [
      app: :hangman,
      version: "1.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  # Write "mix deps.get" to retrieve dependencies
  # Write mix deps.clean --unused --unlock
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      # { :fetcher,  git: "https://repo.acme.com/fetcher", tag: "1.7" },
      # { :pusher,   github: "pragdave/pusher" },
      {:dictionary, git: "https://github.com/carloscasalar/dictionary.git", tag: "1.0.0"}
    ]
  end
end
