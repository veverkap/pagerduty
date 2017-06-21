defmodule PagerDuty.EscalationRule do
  @moduledoc ~S"""
  Delay and targets of [escalation policy](PagerDuty.EscalationRule.html)

  ## Attributes
    * `@id`: 
    * `@escalation_delay_in_minutes`: The number of minutes before an unacknowledged incident escalates away from this rule.
    * `@targets`: The [targets](PagerDuty.EscalationTarget.html) an incident should be assigned to upon reaching this rule.
  """
  defstruct id: nil, escalation_delay_in_minutes: nil, targets: []
  @type t :: %__MODULE__{
    id: String.t,
    escalation_delay_in_minutes: integer,
    targets: list(PagerDuty.EscalationTarget)
  }

  def new(escalation_rule) do
    struct = struct(PagerDuty.EscalationRule, PagerDuty.Utils.atomize(escalation_rule))
    %PagerDuty.EscalationRule{struct | targets: Enum.map(struct.targets, &PagerDuty.EscalationTarget.new/1)}
  end  

  @doc """
  Checks whether the escalation rule is valid
  An escalation rule is valid when the escalation_delay_in_minutes is set and the targets list is valid

  ## Examples
      iex> rule = %PagerDuty.EscalationRule{}
      ...> PagerDuty.EscalationRule.is_valid?(rule)
      false

      iex> rule = %PagerDuty.EscalationRule{escalation_delay_in_minutes: 10}
      ...> PagerDuty.EscalationRule.is_valid?(rule)
      false     

      iex> rule = %PagerDuty.EscalationRule{escalation_delay_in_minutes: 10, targets: []}
      ...> PagerDuty.EscalationRule.is_valid?(rule)
      false

      iex> invalid_target = %PagerDuty.EscalationTarget{}
      ...> PagerDuty.EscalationTarget.is_valid?(invalid_target)
      false
      ...> rule = %PagerDuty.EscalationRule{escalation_delay_in_minutes: 10, targets: [invalid_target]}
      ...> PagerDuty.EscalationRule.is_valid?(rule)
      false 

      iex> valid_target = %PagerDuty.EscalationTarget{type: "user", id: "FFHSD"}
      ...> PagerDuty.EscalationTarget.is_valid?(valid_target)
      true
      ...> rule = %PagerDuty.EscalationRule{escalation_delay_in_minutes: 10, targets: [valid_target]}
      ...> PagerDuty.EscalationRule.is_valid?(rule)
      true 
  """
  def is_valid?(%PagerDuty.EscalationRule{escalation_delay_in_minutes: nil}), do: false
  def is_valid?(%PagerDuty.EscalationRule{escalation_delay_in_minutes: escalation_delay_in_minutes}) when not is_integer(escalation_delay_in_minutes), do: false
  def is_valid?(%PagerDuty.EscalationRule{targets: []}), do: false
  def is_valid?(%PagerDuty.EscalationRule{targets: targets}) do
    Enum.reduce(targets, true, fn(target, acc) ->
      PagerDuty.EscalationTarget.is_valid?(target) && acc
    end)
  end
end