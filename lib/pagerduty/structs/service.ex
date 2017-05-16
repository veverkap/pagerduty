defmodule PagerDuty.Service do
  @moduledoc ~S"""
  A PagerDuty service represents something you monitor (like a web service, email service, or database service).

  It is a container for related [incidents](PagerDuty.Incident.html) that
  associates them with [escalation policies](PagerDuty.EscalationPolicy.html).

  A service is the focal point for [incident](PagerDuty.Incident.html) management; services specify the configuration for the behavior of [incidents](PagerDuty.Incident.html) triggered on them.

  This behavior includes specifying urgency and performing automated actions based on time of day, [incident](PagerDuty.Incident.html) duration, and other factors.

  #### Integrations
  An integration is an endpoint (like Nagios, email, or an API call) that generates events, which are normalized and de-duplicated by PagerDuty to create [incidents](PagerDuty.Incident.html).

  Integrations feed events into services and provide event management functionality such as filtering and de-duplication.

  [*Read more about services in the PagerDuty Knowledge
  Base*](https://support.pagerduty.com/hc/en-us/sections/200550800-Services).  

  ## Attributes
    * `@id`: id
    * `@summary`: A short-form, server-generated string that provides succinct, important information about an object suitable for primary labeling of an entity in a client. In many cases, this will be identical to `name`, though it is not intended to be an identifier.
    * `@type`: either `service` or `service_reference`
    * `@self`: the API show URL at which the object is accessible 
    * `@html_url`: a URL at which the entity is uniquely displayed in the Web app
    * `@name`: The name of the service.
    * `@description`: The user-provided description of the service.
    * `@auto_resolve_timeout`: Time in seconds that an incident is automatically resolved if left open for that long. Value is `null` if the feature is disabled. (defaults to 14400)
    * `@acknowledgement_timeout`: Time in seconds that an incident changes to the Triggered State after being Acknowledged. Value is `null` if the feature is disabled. (defaults to 1800)
    * `@created_at`: The date/time when this service was created
    * `@status`: The current state of the Service. Valid statuses are:
      * `active`: The service is enabled and has no open incidents.
      * `warning`: The service is enabled and has one or more acknowledged incidents.
      * `critical`: The service is enabled and has one or more triggered incidents.
      * `maintenance`: The service is under maintenance, no new incidents will be triggered during maintenance mode.
      * `disabled`: The service is disabled and will not have any new triggered incidents.
    * `@last_incident_timestamp`: The date/time when the most recent incident was created for this service.
    * `@escalation_policy`: The escalation policy used by this service.
    * `@teams`: The set of [team](PagerDuty.Team.html) associated with this service.
    * `@integrations`: An array containing `Pageduty.Integration` objects that belong to this service. If `integrations` is passed as an argument, these are full objects - otherwise, these are references.
    * `@incident_urgency_rule`: The default urgency for new incidents. Account must have the `urgencies` ability to assign a incident urgency rule.
    * `@support_hours`: The support hours for the service. May be used to define the incidents' urgency. Account must have the `service_support_hours` ability to assign support hours.
    * `@scheduled_actions`: An array containing scheduled actions for the service.
    * `@addons`: The array of add-ons associated with this service.
    * `@alert_creation`: Whether a service creates only incidents, or both alerts and incidents. A service must create alerts in order to enable incident merging.  Valid options are: 
      * "create_incidents" - The service will create one incident and zero alerts for each incoming event.
      * "create_alerts_and_incidents" - The service will create one incident and one associated alert for each incoming event.
   """  
  defstruct id: nil, summary: nil, type: nil, self: nil, html_url: nil, name: nil, description: nil, auto_resolve_timeout: nil, acknowledgement_timeout: nil, created_at: nil, status: nil, last_incident_timestamp: nil, escalation_policy: nil, teams: nil, integrations: nil, incident_urgency_rule: nil, support_hours: nil, scheduled_actions: nil, addons: nil, alert_creation: nil
  @type t :: %__MODULE__{
    id: String.t,
    summary: String.t,
    type: String.t,
    self: String.t,
    html_url: String.t,
    name: String.t,
    description: String.t,
    auto_resolve_timeout: integer,
    acknowledgement_timeout: integer,
    created_at: String.t,
    status: String.t,
    last_incident_timestamp: String.t,
    escalation_policy: String.t,
    teams: list(PagerDuty.Team),
    integrations: list(PagerDuty.Integration),
    incident_urgency_rule: String.t,
    support_hours: String.t,
    scheduled_actions: list(PagerDuty.ScheduledAction),
    addons: list(PagerDuty.Addon),
    alert_creation: String.t
  }

  def new(service) do
    service_struct = struct(PagerDuty.Service, PagerDuty.Utils.atomize(service))
  end
end
