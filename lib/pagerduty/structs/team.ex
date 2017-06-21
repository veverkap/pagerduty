defmodule PagerDuty.Team do
  @moduledoc ~S"""
  A team is a collection of [users](PagerDuty.User.html) and [escalation policies](PagerDuty.EscalationPolicy.html) that represent a group of people within an organization.

  Teams can be used throughout the API and PagerDuty applications to filter information to only what is relevant for one or more teams.
  
  The account must have the teams ability to use the following endpoints.

  [*Read more about teams in the PagerDuty Knowledge
  Base*](https://support.pagerduty.com/hc/en-us/articles/204072090-How-to-Create-Teams-in-PagerDuty-).  

  ## Attributes
    * `@id`: id
    * `@summary`: A short-form, server-generated string that provides succinct, important information about an object suitable for primary labeling of an entity in a client. In many cases, this will be identical to `name`, though it is not intended to be an identifier.
    * `@type`: either `team` or `team_reference`
    * `@self`: the API show URL at which the object is accessible 
    * `@html_url`: a URL at which the entity is uniquely displayed in the Web app
    * `@name`: The name of the team.
    * `@description`: The description of the team.
  """
  defstruct id: nil, summary: nil, type: nil, self: nil, html_url: nil, name: nil, description: nil
  @type t :: %__MODULE__{
    id: String.t,
    summary: String.t,
    type: String.t,
    self: String.t,
    html_url: String.t,
    name: String.t,
    description: String.t
  }

  def new(team) do
    struct(PagerDuty.Team, PagerDuty.Utils.atomize(team))
  end  
end
