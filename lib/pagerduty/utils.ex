defmodule PagerDuty.Utils do
  @moduledoc ~S"""
  A number of utility methods
  """
  
  @doc ~S"""
  Atomizes an enumerable

  ## Examples

      iex> item = []
      ...> PagerDuty.Utils.atomize(item)
      []

      iex> item = "dog"
      ...> PagerDuty.Utils.atomize(item)
      :dog

      iex> item = [{ "id", 100 }, { "name", "joe"}]
      ...> PagerDuty.Utils.atomize(item)
      [id: 100, name: "joe"]

      iex> PagerDuty.Utils.atomize(%{"id" => 311, "name" => "Legal Team1"})
      [id: 311, name: "Legal Team1"]
  """  
  def atomize(item) when is_list(item) or is_map(item) do
    Enum.map(item, fn({k, v}) -> 
      case is_atom(k) do
        true ->
          {k, v}
        _ ->
          {String.to_atom(k), v}     
      end
    end)
  end  
  def atomize(item) when is_binary(item), do: String.to_atom(item)
  def atomize(item) when not is_list(item) and not is_map(item), do: item
end