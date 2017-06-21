defmodule PagerDuty.ContactMethod do
  @moduledoc ~S"""
  The method to contact a [user](PagerDuty.User.html).
    
  ## Attributes
    * `@id`: id
    * `@summary`: A short-form, server-generated string that provides succinct, important information about an object suitable for primary labeling of an entity in a client. In many cases, this will be identical to `name`, though it is not intended to be an identifier.
    * `@type`: one of:
      * `email_contact_method`
      * `phone_contact_method`
      * `push_notification_contact_method`
      * `sms_contact_method`
    * `@self`: the API show URL at which the object is accessible 
    * `@html_url`: a URL at which the entity is uniquely displayed in the Web app
    * `@label`: The label (e.g., "Work", "Mobile", etc.).
    * `@address`: The "address" to deliver to: email, phone number, etc., depending on the type
  """  
  defstruct id: nil, summary: nil, type: nil, self: nil, html_url: nil, label: nil, address: nil
  @type t :: %__MODULE__{
    id: String.t,
    summary: String.t,
    type: String.t,
    self: String.t,
    html_url: String.t,
    label: String.t, 
    address: String.t
  } 

  def new(contact_method) do
    struct(PagerDuty.ContactMethod, PagerDuty.Utils.atomize(contact_method))  
  end
end
