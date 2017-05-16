defmodule PagerDuty.Assignment do
  @moduledoc ~S"""
  User assigned incident
  
  ## Attributes
    * `@at`: Time at which the assignment was created.
    * `@assignee`: `PagerDuty.User` that was assigned.
  """  
  defstruct at: nil, assignee: %PagerDuty.User{}
  @type t :: %__MODULE__{
    at: String.t,
    assignee: PagerDuty.User
  }  

  @doc ~S"""
  Generates a new `PagerDuty.Assignment` from a map

  ## Examples

      iex> map = %{at: "2015-11-10T00:31:52Z", assignee: %{id: "PXPGF42", type: "user_reference", summary: "Earline Greenholt", self: "https://api.pagerduty.com/users/PXPGF42", html_url: "https://subdomain.pagerduty.com/users/PXPGF42"}}
      ...> result = PagerDuty.Assignment.new(map)
      ...> result.at
      "2015-11-10T00:31:52Z"
      ...> result.assignee.id
      "PXPGF42"
      ...> result.assignee.type
      "user_reference"
      ...> result.assignee.summary
      "Earline Greenholt"
      ...> result.assignee.self
      "https://api.pagerduty.com/users/PXPGF42"
      ...> result.assignee.html_url
      "https://subdomain.pagerduty.com/users/PXPGF42"

      iex> decoded = ~s<{"at": "2015-11-10T00:31:52Z","assignee": {"id": "PXPGF42","type": "user_reference","summary": "Earline Greenholt","self": "https://api.pagerduty.com/users/PXPGF42","html_url": "https://subdomain.pagerduty.com/users/PXPGF42"}}>
      ...> |> Poison.decode!
      ...> result = PagerDuty.Assignment.new(decoded)
      ...> result.at
      "2015-11-10T00:31:52Z"
      ...> result.assignee.id
      "PXPGF42"
      ...> result.assignee.type
      "user_reference"
      ...> result.assignee.summary
      "Earline Greenholt"
      ...> result.assignee.self
      "https://api.pagerduty.com/users/PXPGF42"
      ...> result.assignee.html_url
      "https://subdomain.pagerduty.com/users/PXPGF42"
  """
  def new(assignment) do
    assignment_struct = struct(PagerDuty.Assignment, PagerDuty.Utils.atomize(assignment))
    %PagerDuty.Assignment{assignment_struct | assignee: PagerDuty.User.new(assignment_struct.assignee)}
  end

  @doc ~S"""
  Checks whether the assignment is valid


  ## Examples
      iex> assignment = %PagerDuty.Assignment{}
      ...> PagerDuty.Assignment.is_valid?(assignment)
      false

      iex> assignment = %PagerDuty.Assignment{at: "2015-11-10T00:31:52Z"}
      ...> PagerDuty.Assignment.is_valid?(assignment)
      false      

      iex> assignment = %PagerDuty.Assignment{assignee: %PagerDuty.User{}}
      ...> PagerDuty.Assignment.is_valid?(assignment)
      false

      iex> assignment = %PagerDuty.Assignment{assignee: %PagerDuty.User{}, at: "2015-11-10T00:31:52Z"}
      ...> PagerDuty.Assignment.is_valid?(assignment)
      true
  """
  def is_valid?(%PagerDuty.Assignment{at: at, assignee: assignee}) when not is_nil(at) and not is_nil(assignee), do: true
  def is_valid?(%PagerDuty.Assignment{at: at, assignee: assignee}) when is_nil(at) or is_nil(assignee), do: false  
end
