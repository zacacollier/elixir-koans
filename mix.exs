defmodule Koans.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_koans,
     version: "0.0.1",
     elixir: ">= 1.3.0 and < 2.0.0",
     elixirc_paths: elixirc_path(Mix.env),
     deps: deps()]
  end

  def application do
    [mod: {ElixirKoans, []},
     applications: applications(Mix.env)]
  end

  defp applications(:test), do: applications(:prod) ++ [:briefly]
  defp applications(_), do: [:file_system, :logger]

  defp deps do
    [
      {:file_system, "~> 0.2"},
      {:briefly, "~> 0.3", only: [:test]}
    ]
  end

  defp elixirc_path(:test), do: ["lib/", "test/support"]
  defp elixirc_path(_), do: ["lib/"]
end
