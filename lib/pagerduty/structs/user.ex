defmodule PagerDuty.User do
  @moduledoc ~S"""
  PagerDuty users are members of a PagerDuty account that have the ability to interact with [incidents](PagerDuty.Incident.html) and other data on the account.
  
  Users are fundamental agents of different types of actions in PagerDuty.
  A user can, among other things:

  - acknowlege, reassign, snooze, escalate, and resolve [incidents](PagerDuty.Incident.html)
  - configure [services](PagerDuty.Service.html), [escalation policies](PagerDuty.EscalationPolicy.html),
  [integrations](PagerDuty.Integration.html), [on-call schedules](PagerDuty.Schedule.html),[teams](PagerDuty.Team.html), and
  more.
  - go [on call](PagerDuty.Oncall.html) for one or more [schedules](PagerDuty.Schedule.html) or [escalation
  policies](PagerDuty.EscalationPolicy.html)
  - receive [notifications](PagerDuty.Notification.html)

  Depending on a user's role, he or she may have access to different parts of the account's data.

  [*Read more about users in the PagerDuty Knowledge
  Base*](https://support.pagerduty.com/hc/en-us/sections/200550780-Users).  

  ## Attributes
    * `@id`: id
    * `@summary`: A short-form, server-generated string that provides succinct, important information about an object suitable for primary labeling of an entity in a client. In many cases, this will be identical to `name`, though it is not intended to be an identifier.
    * `@type`: either `incident` or `incident_reference`
    * `@self`: the API show URL at which the object is accessible 
    * `@html_url`: a URL at which the entity is uniquely displayed in the Web app
    * `@name`: The name of the user. maxLength: 100
    * `@email`: The user's email address. minLength: 6 / maxLength: 100
    * `@time_zone`: The preferred time zone name. If null, the account's time zone will be used.
    * `@color`: The schedule color.
    * `@role:`: The user role.  One of `admin`, `limited_user`, `owner`, `read_only_user` or `user`.  Account must have the `read_only_users` ability to set a user as a `read_only_user`.
    * `@avatar_url`: The URL of the user's avatar.
    * `@description`: The user's bio.
    * `@invitation_sent`: If true, the user has an outstanding invitation.
    * `@job_title`: The user's title. maxLength: 100
    * `@teams`: The list of [teams](PagerDuty.Team.html) to which the user belongs. Account must have the `teams` ability to set this.
    * `@contact_methods`: The list of [contact methods](PagerDuty.ContactMethod.html) for the user.
    * `@notification_rules`: The list of [notification rules](PagerDuty.NotificationRule.html) for the user.
  """  
  defstruct id: nil, summary: nil, type: nil, self: nil, html_url: nil,
            name: nil,
            email: nil,
            time_zone: nil,
            color: nil,
            role: nil,
            avatar_url: nil,
            description: nil,
            invitation_sent: nil,
            job_title: nil,
            teams: [],
            contact_methods: [],
            notification_rules: []

  @type t :: %__MODULE__{
    id: String.t,
    summary: String.t,
    type: String.t,
    self: String.t,
    html_url: String.t,
    name: String.t,
    email: String.t,
    time_zone: String.t,
    color: String.t,
    role: String.t,
    avatar_url: String.t,
    description: String.t,
    invitation_sent: boolean,
    job_title: String.t,
    teams: [%PagerDuty.Team{}],
    contact_methods: [%PagerDuty.ContactMethod{}],
    notification_rules: [%PagerDuty.NotificationRule{}]
  }

  @doc """
  Generates a new `PagerDuty.User` from a map
  """
  def new(user) do
    struct(PagerDuty.User, PagerDuty.Utils.atomize(user))
  end
end
