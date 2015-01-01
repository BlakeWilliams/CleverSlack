defmodule CleverSlack.Mixfile do
  use Mix.Project

  def project do
    [app: :clever_slack,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end

  def application do
    [applications: [:logger, :slack],
     mod: {CleverSlack, []}]
  end

  defp deps do
    [{:slack, "~> 0.0.4"},
     {:cleverbot, "~> 0.0.1"},
     {:websocket_client, git: "https://github.com/jeremyong/websocket_client"}]
  end
end
