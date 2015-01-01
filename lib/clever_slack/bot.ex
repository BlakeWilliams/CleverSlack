defmodule CleverSlack.Bot do
  use Slack
  @token System.get_env("SLACK_TOKEN")

  def start_link({:ok, pid}) do
    Slack.start_link(__MODULE__, @token, pid)
  end

  def init(initial_state, _socket) do
    {:ok, initial_state}
  end

  def handle_message({:type, "message", response}, slack, pid) do
    name_regex = ~r/^.?#{slack.me.name}\s*:?/
    message = normalize(response.text, slack.me)

    if Regex.match?(name_regex, message) do
      message = Regex.replace(name_regex, message, "")
      reply = Cleverbot.think(pid, message)
      Slack.send_message(reply, response.channel, slack)
    end

    {:ok, pid}
  end

  def handle_message(_message , _socket, state), do: {:ok, state}

  defp normalize(text, me) do
    String.replace(text, "<@#{me.id}>", me.name)
  end
end
