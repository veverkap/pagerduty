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
    * `@escalation_rules`: list of [escalation rules](PagerDuty.EscalationRule.html)
    * `@services`: Associated [services](PagerDuty.Service.html) (minLength 0)
    * `@teams`: [Teams](PagerDuty.Team.html) associated with the policy. Account must have the `teams` ability to use this parameter. (minLength 0)
  """
  defstruct id: nil, summary: nil, type: nil, self: nil, html_url: nil, name: nil, description: nil, num_loops: nil, repeat_enabled: nil, escalation_rules: [], services: [], teams: []
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
    escalation_rules: list(PagerDuty.EscalationRule),
    services: list(PagerDuty.Service),
    teams: list(PagerDuty.Team)
  }

  def new(escalation_policy) do
    struct = struct(PagerDuty.EscalationPolicy, PagerDuty.Utils.atomize(escalation_policy))
    %PagerDuty.EscalationPolicy{struct | escalation_rules: Enum.map(struct.escalation_rules, &PagerDuty.EscalationRule.new/1),
                                         services: Enum.map(struct.services, &PagerDuty.Service.new/1),
                                         teams: Enum.map(struct.teams, &PagerDuty.Team.new/1)}
  end

  @doc """
  Checks whether the escalation policy is valid
  An escalation policy is valid when is has the correct `type` (either `escalation_policy` or `escalation_policy_reference`), the required attribute of `name` and valid escalation_rules, services and teams

  ## Examples
      iex> policy = %PagerDuty.EscalationPolicy{name: "test"}
      ...> PagerDuty.EscalationPolicy.is_valid?(policy)
      false

      iex> policy = %PagerDuty.EscalationPolicy{name: "test", type: "something"}
      ...> PagerDuty.EscalationPolicy.is_valid?(policy)
      false     

      iex> policy = %PagerDuty.EscalationPolicy{name: "test", type: "escalation_policy"}
      ...> PagerDuty.EscalationPolicy.is_valid?(policy)
      false

      iex> policy = %PagerDuty.EscalationPolicy{name: "test", type: "escalation_policy", escalation_rules: []}
      ...> PagerDuty.EscalationPolicy.is_valid?(policy)
      false

      iex> policy = %PagerDuty.EscalationPolicy{name: "test", type: "escalation_policy", escalation_rules: [], services: []}
      ...> PagerDuty.EscalationPolicy.is_valid?(policy)
      false      

      iex> policy = %PagerDuty.EscalationPolicy{name: "test", type: "escalation_policy", escalation_rules: [], services: [], teams: []}
      ...> PagerDuty.EscalationPolicy.is_valid?(policy)
      false

      iex> invalid_escalation_rule = %PagerDuty.EscalationRule{}
      ...> PagerDuty.EscalationRule.is_valid?(invalid_escalation_rule)
      false
      ...> valid_service = %PagerDuty.Service{}
      ...> valid_team = %PagerDuty.Team{}
      ...> policy = %PagerDuty.EscalationPolicy{name: "test", type: "escalation_policy", escalation_rules: [invalid_escalation_rule], services: [valid_service], teams: [valid_team]}
      ...> PagerDuty.EscalationPolicy.is_valid?(policy)
      false

      iex> valid_escalation_rule = %PagerDuty.EscalationRule{}
      ...> PagerDuty.EscalationRule.is_valid?(valid_escalation_rule)
      true
      ...> valid_service = %PagerDuty.Service{}
      ...> PagerDuty.Service.is_valid?(valid_service)
      true
      ...> valid_team = %PagerDuty.Team{}
      ...> PagerDuty.Team.is_valid?(valid_team)
      true
      ...> policy = %PagerDuty.EscalationPolicy{name: "test", type: "escalation_policy", escalation_rules: [valid_escalation_rule], services: [valid_service], teams: [valid_team]}
      ...> PagerDuty.EscalationPolicy.is_valid?(policy)
      false
  """
  def is_valid?(%PagerDuty.EscalationPolicy{name: name, type: type}) when is_nil(name) or is_nil(type), do: false
  def is_valid?(%PagerDuty.EscalationPolicy{type: type}) when type != "escalation_policy" and type != "escalation_policy_reference", do: false
  def is_valid?(%PagerDuty.EscalationPolicy{escalation_rules: []}), do: false
  def is_valid?(%PagerDuty.EscalationPolicy{services: []}), do: false
  def is_valid?(%PagerDuty.EscalationPolicy{teams: []}), do: false
  
  def is_valid?(%PagerDuty.EscalationPolicy{escalation_rules: escalation_rules, services: services, teams: teams}) do
    Enum.reduce(escalation_rules, true, fn(rule, acc) ->
      PagerDuty.EscalationRule.is_valid?(rule) && acc
    end) && Enum.reduce(services, true, fn(service, acc) ->
      PagerDuty.Service.is_valid?(service) && acc
    end) && Enum.reduce(teams, true, fn(team, acc) ->
      PagerDuty.Team.is_valid?(team) && acc
    end)
  end
end
