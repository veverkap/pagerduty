defmodule PagerDuty.Api.Notifications do
  @moduledoc ~S"""
  Module encompassing interactions with the notifications API endpoint
  """  
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://api.pagerduty.com"
  plug Tesla.Middleware.Headers, %{"Authorization" => "Token token=y_NbAkKc66ryYTWUXYEu", "Accept" => "application/vnd.pagerduty+json;version=2"}
  plug Tesla.Middleware.JSON

  adapter Tesla.Adapter.Hackney

  def notifications() do
    # query_params = [query: [{:"timeZone", time_zone}, {:"since", since}, {:"until", until}, {:"filter", filter}, {:"include[]", include[]}]]  
    get("/notifications")
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
