defmodule PagerDuty.Agent do
  @moduledoc ~S"""
  The agent (user, service or integration) that created or modified the ILE.

  ## Attributes
    * `@id`: id
    * `@summary`: A short-form, server-generated string that provides succinct, important information about an object suitable for primary labeling of an entity in a client. In many cases, this will be identical to `name`, though it is not intended to be an identifier.
    * `@type`: one of: 
      * `user` or `user_reference`
      * `service` or `service_reference`
      * `integration` or `integration_reference`
    * `@self`: the API show URL at which the object is accessible 
    * `@html_url`: a URL at which the entity is uniquely displayed in the Web app
  """    
  @valid_types ~w<user service integration user_reference service_reference integration_reference>  
  defstruct id: nil, summary: nil, type: nil, self: nil, html_url: nil

  @type t :: %__MODULE__{
    id: String.t,
    summary: String.t,
    type: String.t,
    self: String.t,
    html_url: String.t
  }  
  @doc ~S"""
  Generates a new `PagerDuty.Agent` from a map

  ## Examples

      iex> map = %{type: "user"}
      ...> result = PagerDuty.Agent.new(map)
      ...> result.type
      "user"

      iex> decoded = ~s<{"type": "service"}>
      ...> |> Poison.decode!
      ...> result = PagerDuty.Agent.new(decoded)
      ...> result.type
      "service"  
  """
  def new(agent) do
    struct(PagerDuty.Agent, PagerDuty.Utils.atomize(agent))
  end  

  @doc ~S"""
  Checks whether the agent has a valid type

  ## Examples

      iex> agent = %PagerDuty.Agent.new{type: "dog"}
      ...> PagerDuty.Agent.is_valid?(agent)
      false

      iex> agent = %PagerDuty.Agent.new{type: "user"}
      ...> PagerDuty.Agent.is_valid?(agent)
      false

      iex> agent = %PagerDuty.Agent.new{type: "service"}
      ...> PagerDuty.Agent.is_valid?(agent)
      false

      iex> agent = %PagerDuty.Agent.new{type: "integration"}
      ...> PagerDuty.Agent.is_valid?(agent)
      false

      iex> agent = %PagerDuty.Agent.new{type: "user_reference"}
      ...> PagerDuty.Agent.is_valid?(agent)
      false

      iex> agent = %PagerDuty.Agent.new{type: "service_reference"}
      ...> PagerDuty.Agent.is_valid?(agent)
      false

      iex> agent = %PagerDuty.Agent.new{type: "integration_reference"}
      ...> PagerDuty.Agent.is_valid?(agent)
      false      
  """
  def is_valid?(%PagerDuty.Agent{type: type}) do
    Enum.member?(@valid_types, type)
  end
end