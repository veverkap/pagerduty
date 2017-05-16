defmodule PagerDuty.EscalationPolicy do
  @moduledoc ~S"""
  Escalation policies make sure the right people are alerted at the right time.

  An escalation policy determines what [user](PagerDuty.User.html) or [schedule](PagerDuty.Schedule.html) 
  will be notified first, second, and so on when an [incident](PagerDuty.Incident.html) is
  triggered.

  Escalation policies are used by one or more [service](PagerDuty.Service.html).

  #### Escalation Rules

  An escalation policy is made up of multiple [escalation rules](PagerDuty.EscalationRule.html).

  Each escalation rule represents a level of [on-call](PagerDuty.Oncall.html) duty.

  It specifies one or more [user](PagerDuty.User.html) or [schedule](PagerDuty.Schedule.html) to be notified 
  when an unacknowledged [incident](PagerDuty.Incident.html) reaches that [escalation rule](PagerDuty.EscalationRule.html).

  The first [escalation rule](PagerDuty.EscalationRule.html) in the escalation policy is the [user](PagerDuty.User.html)
  that will be notified first about the triggered [incident](PagerDuty.Incident.html).

  If no [on-call](PagerDuty.Oncall.html) [user](PagerDuty.User.html) for a given [escalation rule](PagerDuty.EscalationRule.html) has 
  acknowledged an [incident](PagerDuty.Incident.html) before the [escalation rule's](PagerDuty.EscalationRule.html)
  escalation delay has elapsed, the [incident](PagerDuty.Incident.html) escalates to the next [escalation rule](PagerDuty.EscalationRule.html).

  [*Read more about escalation policies in the PagerDuty Knowledge
  Base*](https://support.pagerduty.com/hc/en-us/articles/202828950-What-is-an-Escalation-Policy-).  

  ## Attributes
    * `@id`: id
    * `@summary`: A short-form, server-generated string that provides succinct, important information about an object suitable for primary labeling of an entity in a client. In many cases, this will be identical to `name`, though it is not intended to be an identifier.
    * `@type`: either `incident` or `incident_reference`
    * `@self`: the API show URL at which the object is accessible 
    * `@html_url`: a URL at which the entity is uniquely displayed in the Web app
    * `@name`: The name of the escalation policy.
    * `@description`: Escalation policy description.
    * `@num_loops`: The number of times the escalation policy will repeat after reaching the end of its escalation. (defaults to 0) (minimum of 0)
    * `@repeat_enabled`: Whether or not to allow this policy to repeat its escalation rules after the last rule is finished.
    * `@escalation_rules`: 
    * `@services`:  (minLength 0)
    * `@teams`: Teams associated with the policy. Account must have the `teams` ability to use this parameter. (minLength 0)
  """
  defstruct id: nil, summary: nil, type: nil, self: nil, html_url: nil, name: nil, description: nil, num_loops: nil, repeat_enabled: nil, escalation_rules: nil, services: nil, teams: nil
  @type t :: %__MODULE__{
    id: String.t,
    summary: String.t,
    type: String.t,
    self: String.t,
    html_url: String.t,
    name: String.t,
    description: String.t,
    num_loops: integer,
    repeat_enabled: boolean,
    escalation_rules: list(),
    services: list(),
    teams: list()
  }
end
