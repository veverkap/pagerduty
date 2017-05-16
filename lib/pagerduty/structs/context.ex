defmodule PagerDuty.Context do
  @moduledoc ~S"""
  [Link](PagerDuty.LinkContext.html) or [image](PagerDuty.ImageContext.html) associated with [incident](PagerDuty.Incident.html)
  
  ## Attributes
    * `@type`: The type of context being attached to the incident. valid options are: 
      * `link`
      * `image`

  """
  defstruct type: nil
  @type t :: %__MODULE__{
    type: String.t
  }
end