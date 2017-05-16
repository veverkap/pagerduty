defmodule PagerDuty.Api.Notifications do
  @moduledoc ~S"""
  Module encompassing interactions with the abilities API endpoint
  """
  use PagerDuty.Api.Common
  require Logger

  def account_notifications(options \\ []) do
    since = %DateTime{DateTime.utc_now() | day: DateTime.utc_now().day - 10}
            |> DateTime.to_iso8601
    until = DateTime.utc_now()
            |> DateTime.to_iso8601
    defaults = [timeZone: "UTC", since: since, until: until, filter: "email_notification", include: []]
    get("/notifications", query: defaults)
    # query_params = [query: [{:"timeZone", time_zone}, {:"since", since}, {:"until", until}, {:"filter", filter}, {:"include[]", include[]}]]  
    # get("/notifications")
    # method = [method: :get]
    # url = [url: "/notifications"]
    
    # header_params = []
    # body_params = []
    # form_params = []
    # params = query_params ++ header_params ++ body_params ++ form_params
    # opts = []
    # options = method ++ url ++ params ++ opts

    # request(options)
  end
end
