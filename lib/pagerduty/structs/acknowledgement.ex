defmodule PagerDuty.Acknowledgement do
  @moduledoc ~S"""
  Acknowledgement for [incident](PagerDuty.Incident.html)
  
  ## Attributes
    * `@at`: Time at which the acknowledgement was created.
    * `@acknowledger`: [User](PagerDuty.User.html) or [service](PagerDuty.Service.html) that acknowledged.
  """
  defstruct at: nil, acknowledger: nil
  @type t :: %__MODULE__{
    at: String.t,
    acknowledger: String.t
  }
end