defmodule PagerDuty.Api.Common do
  @moduledoc false
  defmacro __using__(_) do
    quote do
      use Tesla, docs: false
      plug Tesla.Middleware.BaseUrl, base_url()
      plug Tesla.Middleware.Headers, headers()
      plug Tesla.Middleware.JSON
      plug Tesla.Middleware.DebugLogger
      adapter Tesla.Adapter.Hackney

      defp handle_response(%Tesla.Env{status: 400}), do: {:error, "Invalid arguments"}
      defp handle_response(%Tesla.Env{status: 401}), do: {:error, "Invalid Credentials"}
      defp handle_response(%Tesla.Env{status: 403}), do: {:error, "Not Authorized"}
      defp handle_response(%Tesla.Env{status: 404}), do: {:error, "Not Found"}
      defp handle_response(%Tesla.Env{status: 429}), do: {:error, "Rate Limit Exceeded"}

      defp base_url do
        Application.get_env(:pagerduty, :pagerduty_url) || "https://api.pagerduty.com"
      end

      defp headers do
        %{"Authorization" => token, "Accept" => "application/vnd.pagerduty+json;version=2", "Content-Type" => "application/json"}        
      end
      
      defp token do
        "Token token=#{Application.get_env(:pagerduty, :api_token)}"
      end
    end
  end
end