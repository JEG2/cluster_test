defmodule Ui.NodeSelectortest do
  use ExUnit.Case, async: true
  alias Ui.NodeSelector

  test "selects node for specific name" do
    selected_node =
      [:"lol@127.0.0.1", :"wat@127.0.0.1"]
      |> NodeSelector.get_node("lol")

    assert selected_node == :"lol@127.0.0.1"
  end

  test "returns self if given an empty list" do
    selected_node =
      [ ]
      |> NodeSelector.get_node("lol")

    assert selected_node == :"nonode@nohost"
  end

  test "returns self if no nodes match" do
    selected_node =
      [:"wat@127.0.0.1"]
      |> NodeSelector.get_node("lol")

    assert selected_node == :"nonode@nohost"
  end

end
