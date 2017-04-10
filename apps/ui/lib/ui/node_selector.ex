defmodule Ui.NodeSelector do
  def get_node([], name) do
    Node.self()
  end
  def get_node(node_list, name) do
    node_list
    |> Enum.filter(&(matches_node_name?(&1, name)))
    |> select_node
  end

  defp matches_node_name?(current_node, name) do
    current_node
    |> Atom.to_string
    |> String.split("@")
    |> hd
    |> Kernel.==(name)
  end

  defp select_node([]), do: Node.self()
  defp select_node(nodes), do: Enum.random(nodes)
  # this should be smarter (use a genserver to track / load balance)
end
