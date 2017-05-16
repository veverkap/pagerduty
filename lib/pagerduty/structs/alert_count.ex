defmodule PagerDuty.AlertCount do
  @moduledoc ~S"""
  A summary of the number of alerts by status.

  ## Attributes
    * `@triggered`: The count of triggered alerts
    * `@resolved`: The count of resolved alerts
    * `@all`: The total count of alerts
  """  
  defstruct triggered: 0, resolved: 0, all: 0
  @type t :: %__MODULE__{
    triggered: integer,
    resolved: integer,
    all: integer
  } 

  @doc ~S"""
  Generates a new `PagerDuty.AlertCount` from a map

  ## Examples

      iex> map = %{triggered: 1, resolved: 2, all: 3}
      ...> result = PagerDuty.AlertCount.new(map)
      ...> result.triggered
      1
      ...> result.resolved
      2
      ...> result.all
      3

      iex> decoded = ~s<{"triggered": 1, "resolved": 2, "all": 3}>
      ...> |> Poison.decode!
      ...> result = PagerDuty.AlertCount.new(decoded)
      ...> result.triggered
      1
      ...> result.resolved
      2
      ...> result.all
      3      
  """
  def new(alert_count) do
    struct(PagerDuty.AlertCount, PagerDuty.Utils.atomize(alert_count))
  end    
end
