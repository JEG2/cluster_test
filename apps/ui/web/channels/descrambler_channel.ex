defmodule Ui.DescramblerChannel do
  use Phoenix.Channel

  def join("services:descrambler", _message, socket) do
    {:ok, socket}
  end

  def handle_in("descramble", %{"body" => scrambled}, socket) do
    :rpc.call(Node.self(), Descrambler, :descramble, [scrambled, self()])
    # Descrambler.descramble(scrambled, self())
    {:noreply, socket}
  end

  def handle_info({:descrambled, _scrambled, matches}, socket) do
    push(socket, "descrambled", %{matches: matches})
    {:noreply, socket}
  end
end
