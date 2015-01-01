defmodule CleverSlack do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(CleverSlack.Bot, [Cleverbot.start_link])
    ]

    opts = [strategy: :one_for_one, name: CleverSlack.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
