defmodule PagerDuty.Schedule do
  @moduledoc ~S"""
  Schedule of oncall
  
  ## Attributes
    * `@id`: id
    * `@summary`: A short-form, server-generated string that provides succinct, important information about an object suitable for primary labeling of an entity in a client. In many cases, this will be identical to `name`, though it is not intended to be an identifier.
    * `@type`: 
    * `@self`: the API show URL at which the object is accessible 
    * `@html_url`: a URL at which the entity is uniquely displayed in the Web app
    * `@schedule_layers`: A list of schedule layers.
    * `@time_zone`: The time zone of the schedule.
    * `@name`: The name of the schedule
    * `@description`: The description of the schedule
    * `@final_schedule`: The final layer is a special layer that contains the result of all of the previous layers put together. This layer cannot be edited.
    * `@overrides_subschedule`: The override layer is a special layer where all of the override entries are stored.
    * `@escalation_policies`: An array of all of the escalation policies that uses this schedule.
    * `@users`: An array of all of the users on the schedule.
  """
  defstruct id: nil, summary: nil, type: nil, self: nil, html_url: nil, schedule_layers: nil, time_zone: nil, name: nil, description: nil, final_schedule: nil, overrides_subschedule: nil, escalation_policies: nil, users: nil
  @type t :: %__MODULE__{
    id: String.t,
    summary: String.t,
    type: String.t,
    self: String.t,
    html_url: String.t,
    schedule_layers: list(),
    time_zone: String.t,
    name: String.t,
    description: String.t,
    final_schedule: String.t,
    overrides_subschedule: String.t,
    escalation_policies: list(),
    users: list()
  }
end