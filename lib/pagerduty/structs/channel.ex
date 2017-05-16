defmodule PagerDuty.Channel do
  @moduledoc ~S"""
  Polymorphic object representation of the means by which the action was channeled. 

  Has different formats depending on type, indicated by `@type`. 

  Will be one of `auto`, `email`, `api`, `nagios`, or `timeout` if `@type` is `service`. 
  
  Will be one of `email`, `sms`, `website`, `web_trigger`, or `note` if `@type` is `user`. 

  ## Attributes
    * `@type`: type of action
  """
  defstruct type: nil
  @type t :: %__MODULE__{
    type: String.t
  }
end