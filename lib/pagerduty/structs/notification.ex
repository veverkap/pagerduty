defmodule PagerDuty.Notification do
  @moduledoc ~S"""
  When an [incident](PagerDuty.Incident.html) is triggered or escalated, it creates a notification.

  Notifications are messages containing the details of the [incident](PagerDuty.Incident.html), and can be sent through SMS, email, phone calls, and push notifications.

  Notifications cannot be created directly through the API; they are a result of other actions.

  The API provides read-only access to the notifications generated by PagerDuty.

  [*Read more about notifications in the PagerDuty Knowledge
  Base*](https://support.pagerduty.com/hc/en-us/articles/202828840-What-is-an-Alert-Notification-).

  ## Attributes
    * `@id`: 
    * `@type`: The type of notification. valid options are: 
      * `sms_notification`
      * `email_notification`
      * `phone_notification`
      * `push_notification`
    * `@started_at`: The time at which the notification was sent
    * `@address`: The address where the notification was sent. This will be null for notification type `push_notification`.
    * `@user`: The [user](PagerDuty.User.html) the notification was sent to.
  """
  defstruct id: nil, type: nil, started_at: nil, address: nil, user: nil
  @type t :: %__MODULE__{
    id: String.t,
    type: String.t,
    started_at: String.t,
    address: String.t,
    user: PagerDuty.User
  }
end