defmodule PagerDuty.IncidentAction do
  @moduledoc ~S"""
  An incident action is a pending change to an incident that will automatically happen at some future time.
    
  ## Attributes
    * `@id`: id
    * `@summary`: A short-form, server-generated string that provides succinct, important information about an object suitable for primary labeling of an entity in a client. In many cases, this will be identical to `name`, though it is not intended to be an identifier.
    * `@type`: either `incident` or `incident_reference`
    * `@self`: the API show URL at which the object is accessible 
    * `@html_url`: a URL at which the entity is uniquely displayed in the Web app
  """  
  defstruct id: nil, summary: nil, type: nil, self: nil, html_url: nil
end
