defmodule PagerDuty.Mixfile do
  use Mix.Project

  def project do
    [app: :pagerduty,
     version: "0.0.1",
     elixir: "~> 1.0",
     description: description(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package(),
     deps: deps(),
     name: "PagerDuty Elixir",
     source_url: "https://github.com/veverkap/pagerduty"]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison, :hackney],
     mod: {PagerDuty, []}]    
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:tesla, "~> 0.6.0"},
      {:httpoison, "~> 0.6"},
      {:poison, ">= 1.0.0"},
      {:hackney, "~> 1.6"},


      {:apex, "~> 0.5", only: [:dev, :test]},
      {:bypass, "~> 0.1", only: [:dev, :test]},
      {:coverex, "~> 1.4.10", only: :test},
      {:credo, "~> 0.3", only: [:dev, :test]},
      {:ex_machina, "~> 1.0", only: [:dev, :test]},



      {:ex_doc, "~> 0.14", only: :dev, runtime: false},
      {:ex_guard, "~> 1.1.1", only: :dev, runtime: false}
    ]
  end

  defp description do
    """
    Elixir client for PagerDuty v2 API 
    """
  end

  defp package do
    # These are the default files included in the package
    [
      name: :pagerduty,
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["Patrick Veverka"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/veverkap/pagerduty",
               "Docs" => "https://github.com/veverkap/pagerduty",
               "API Docs" => "https://v2.developer.pagerduty.com/v2/page/api-reference"}
    ]
  end  
end
