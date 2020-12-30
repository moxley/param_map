defmodule ParamMap.MixProject do
  use Mix.Project

  def project do
    [
      app: :param_map,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: false,
      deps: deps(),

      # Package
      name: "ParamMap",
      package: package(),
      description: description(),
      source_url: "https://github.com/moxley/param_map",
      docs: [
        # The main page in the docs
        main: "ParamMap",
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: []
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.23", only: :dev, runtime: false}
    ]
  end

  defp description do
    """
    Use atom keys to access values in string-keyed maps.
    """
  end

  defp package do
    [
      name: :param_map,
      files: ~w(lib .formatter.exs mix.exs README.md LICENSE),
      maintainers: ["Moxley Stratton (github.com/moxley)"],
      licenses: ["Apache Public License, version 2.0"],
      links: %{"GitHub" => "https://github.com/moxley/param_map"}
    ]
  end
end
