defmodule Clock.MixProject do
  use Mix.Project

  def project do
    [
      app: :clock,
      version: "0.1.3",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Clock, []},
      applications: [
        :logger_file_backend,
        # Add edeliver to the END of the list
        :edeliver
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:logger_file_backend, "~> 0.0.10"},
      {:distillery, "~> 2.0", warn_missing: false},
      {:edeliver, ">= 1.6.0"},
    ]
  end
end
