defmodule PagerDuty.Integration do
  @moduledoc ~S"""
  An integration is an endpoint (like Nagios, email, or an API call) that generates events, which are normalized and de-duplicated by PagerDuty to create [incidents](PagerDuty.Incident.html).

  Integrations feed events into services and provide event management functionality such as filtering and de-duplication.

  ## Attributes
    * `@id`: id
    * `@summary`: A short-form, server-generated string that provides succinct, important information about an object suitable for primary labeling of an entity in a client. In many cases, this will be identical to `name`, though it is not intended to be an identifier.
    * `@type`: 
    * `@self`: the API show URL at which the object is accessible 
    * `@html_url`: a URL at which the entity is uniquely displayed in the Web app
    * `@type`:  valid options are: 
      * `aws_cloudwatch_inbound_integration`
      * `aws_cloudwatch_inbound_integration_reference`
      * `cloudkick_inbound_integration`
      * `cloudkick_inbound_integration_reference`
      * `event_transformer_api_inbound_integration`
      * `event_transformer_api_inbound_integration_reference`
      * `generic_email_inbound_integration`
      * `generic_email_inbound_integration_reference`
      * `generic_events_api_inbound_integration`
      * `generic_events_api_inbound_integration_reference`
      * `keynote_inbound_integration`
      * `keynote_inbound_integration_reference`
      * `nagios_inbound_integration`
      * `nagios_inbound_integration_reference`
      * `pingdom_inbound_integration`
      * `pingdom_inbound_integration_reference`
      * `sql_monitor_inbound_integration`
      * `sql_monitor_inbound_integration_reference`
    * `@name`: The name of this integration.
    * `@service`: The PagerDuty service that the integration belongs to.
    * `@created_at`: The date/time when this integration was created.
    * `@vendor`: The vendor that this integration integrates with, if applicable. This can only be set on creation
  """
  defstruct id: nil, summary: nil, type: nil, self: nil, html_url: nil, name: nil, service: nil, created_at: nil, vendor: nil
  @type t :: %__MODULE__{
    id: String.t,
    summary: String.t,
    type: String.t,
    self: String.t,
    html_url: String.t,
    name: String.t,
    service: String.t,
    created_at: String.t,
    vendor: String.t
  }
end