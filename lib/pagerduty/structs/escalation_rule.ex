defmodule PagerDuty.EscalationRule do
  @moduledoc ~S"""
  Delay and targets of [escalation policy](PagerDuty.EscalationPolicy.html)

  ## Attributes
    * `@id`: 
    * `@escalation_delay_in_minutes`: The number of minutes before an unacknowledged incident escalates away from this rule.
    * `@targets`: The [targets](PagerDuty.EscalationTarget.html) an incident should be assigned to upon reaching this rule.
  """
  defstruct id: nil, escalation_delay_in_minutes: nil, targets: nil
  @type t :: %__MODULE__{
    id: String.t,
    escalation_delay_in_minutes: integer,
    targets: list(%PagerDuty.EscalationTarget{})
  }
end