defmodule PagerDuty.LinkContext do
  @moduledoc ~S"""
  Link type of `PagerDuty.Context`
  
  ## Attributes
    * `@href`: The link being attached to the incident
    * `@text`: The text that will be displayed as the link.
  """
  defstruct href: nil, text: nil
  @type t :: %__MODULE__{
    href: String.t,
    text: String.t
  }
end