defmodule Descrambler do
  use GenServer

  @word_list Path.expand(
    "priv/word_list.txt",
    Application.app_dir(:descrambler)
  )

  def start_link(word_list \\ @word_list) do
    GenServer.start_link(__MODULE__, {word_list}, name: {:global, __MODULE__})
  end

  def descramble(scrambled, from) do
    GenServer.cast({:global, __MODULE__}, {:descramble, scrambled, from})
  end

  def init({word_list}) do
    {:ok, word_list}
  end

  def handle_cast({:descramble, scrambled, from}, word_list) do
    matches = match(scrambled, word_list)
    send(from, {:descrambled, scrambled, matches})
    {:noreply, word_list}
  end

  defp match(scrambled, word_list) do
    scrambled_signature = signature(scrambled)
    word_list
    |> File.stream!
    |> Stream.map(&String.trim/1)
    |> Enum.filter(fn line -> scrambled_signature == signature(line) end)
  end

  defp signature(string) do
    string
    |> String.downcase
    |> String.replace(~r{[^a-z]+}, "")
    |> String.graphemes
    |> Enum.sort
    |> Enum.join
  end
end
