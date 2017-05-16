defmodule PagerDuty.ImageContext do
  @moduledoc ~S"""
  Image type of `PagerDuty.Context`
  
  ## Attributes
    * `@src`: The source of the image being attached to the incident
    * `@href`: Optional link for the image
    * `@alt`: Optional alt text for the image
  """
  defstruct src: nil, href: nil, alt: nil
  @type t :: %__MODULE__{
    src: String.t,
    href: String.t,
    alt: String.t
  }
end