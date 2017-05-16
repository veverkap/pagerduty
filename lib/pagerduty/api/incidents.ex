defmodule PagerDuty.Api.Incidents do
  @moduledoc ~S"""
  Module encompassing interactions with the incidents API endpoint
  """  
  use PagerDuty.Api.Common
  require Logger

  def create_incident(nil, _), do: {:error, "From email address is required"}
  def create_incident("", _), do: {:error, "From email address is required"}
  def create_incident(_, nil), do: {:error, "Incident struct is required"}

  def create_incident(_, %PagerDuty.Incident{title: nil}), do: {:error, "Incident title is required"}
  def create_incident(_, %PagerDuty.Incident{service: nil}), do: {:error, "Service reference is required"}  
  def create_incident(_, %PagerDuty.Incident{service: service}) when not is_map(service), do: {:error, "Service reference should be a struct"}  

# {
#   "incident": {
#     "title": "The server is on fire.",
#     "service": {
#       "id": "P407C9R",
#       "type": "service_reference"
#     },
#   }
# }

  def create_incident(from_email, incident) do

    item = %{"incident" => %{"title" => "BLAH", "service" => %{"id" => "P407C9R", "type" => "service_reference"}}}
           |> Poison.encode!

    Tesla.post(base_url <> "/incidents", 
               item, 
               headers: %{"Content-Type" => "application/json", 
                          "Accept" => "application/vnd.pagerduty+json;version=2", 
                          "From" => from_email,
                          "Authorization" => token})
    |> IO.inspect
    # |> handle_response

    IO.inspect from_email
    IO.inspect incident
  end
end