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

  def new(escalation_target) do
    struct(PagerDuty.EscalationTarget, PagerDuty.Utils.atomize(escalation_target))
  end

  @doc """
  Checks whether the escalation target is valid
  An escalation target is valid when the id and type are set

  ## Examples
      iex> target = %PagerDuty.EscalationTarget{}
      ...> PagerDuty.EscalationTarget.is_valid?(target)
      false

      iex> target = %PagerDuty.EscalationTarget{type: "blah"}
      ...> PagerDuty.EscalationTarget.is_valid?(target)
      false

      iex> target = %PagerDuty.EscalationTarget{type: "user"}
      ...> PagerDuty.EscalationTarget.is_valid?(target)
      false

      iex> target = %PagerDuty.EscalationTarget{type: "blah", id: "FFHSD"}
      ...> PagerDuty.EscalationTarget.is_valid?(target)
      false

      iex> target = %PagerDuty.EscalationTarget{type: "user", id: "FFHSD"}
      ...> PagerDuty.EscalationTarget.is_valid?(target)
      true      
  """
  def is_valid?(%PagerDuty.EscalationTarget{id: nil}), do: false
  def is_valid?(%PagerDuty.EscalationTarget{type: nil}), do: false
  def is_valid?(%PagerDuty.EscalationTarget{type: type}) when type != "user" and type != "schedule" and type != "user_reference" and type != "schedule_reference", do: false
  def is_valid?(%PagerDuty.EscalationTarget{id: id, type: type}) when not is_nil(id) and not is_nil(type), do: true
end