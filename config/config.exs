# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config
config :pagerduty, pagerduty_url: "https://api.pagerduty.com"
config :pagerduty, api_token: "y_NbAkKc66ryYTWUXYEu" #test
import_config "#{Mix.env}.exs"