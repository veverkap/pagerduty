defmodule PagerDuty.EscalationTarget do
  @moduledoc ~S"""
  The target this incident should be assigned to upon reaching this rule.
  
  ## Attributes
    * `@id`: id
    * `@summary`: A short-form, server-generated string that provides succinct, important information about an object suitable for primary labeling of an entity in a client. In many cases, this will be identical to `name`, though it is not intended to be an identifier.
    * `@type`: 
    * `@self`: the API show URL at which the object is accessible 
    * `@html_url`: a URL at which the entity is uniquely displayed in the Web app
    * `@type`:  valid options are: 
      * `user`
      * `schedule`
      * `user_reference`
      * `schedule_reference`
  """
  defstruct id: nil, summary: nil, type: nil, self: nil, html_url: nil, type: nil
  @type t :: %__MODULE__{
    id: String.t,
    summary: String.t,
    type: String.t,
    self: String.t,
    html_url: String.t,
    type: String.t
  }
end